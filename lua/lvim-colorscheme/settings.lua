-- lvim-colorscheme.settings: the runtime-configurable option set.
--
-- One spec list drives BOTH the config panel (`config_ui`) and the persistence restore, so
-- they never drift. Each spec maps a persistence key (matching control-center's setting
-- names, for mutual recognition) to a dot-path inside `config.options`, plus the panel row
-- type. Values are applied live through `lvim-colorscheme.set` and persisted via `store`.
--
---@module "lvim-colorscheme.settings"

local config = require("lvim-colorscheme.config")
local store = require("lvim-colorscheme.store")

local M = {}

-- Stepped 0.1 .. 1.0 fractions, reused for the amount / brightness selects.
local FRACTIONS = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0 }
local STYLE_OPTS = { "dark", "transparent", "normal" }

---@class lvim-colorscheme.Setting
---@field name    string   persistence key (matches the control-center setting names)
---@field label   string
---@field group   string   tab the row belongs to
---@field type    "bool"|"select"
---@field options any[]|nil
---@field path    string   dot-path into config.options
---@field italic? boolean  encode/decode bool <-> { italic = true }

---@type lvim-colorscheme.Setting[]
M.specs = {
    -- ── Background ──────────────────────────────────────────────────────────
    {
        name = "transparent",
        label = "Transparent background",
        group = "Background",
        type = "bool",
        path = "transparent",
    },
    {
        name = "sidebars",
        label = "Sidebar style",
        group = "Background",
        type = "select",
        options = STYLE_OPTS,
        path = "styles.sidebars",
    },
    {
        name = "floats",
        label = "Float style",
        group = "Background",
        type = "select",
        options = STYLE_OPTS,
        path = "styles.floats",
    },
    {
        name = "terminal_colors",
        label = "Terminal colors",
        group = "Background",
        type = "bool",
        path = "terminal_colors",
    },
    {
        name = "auto_background",
        label = "Auto background",
        group = "Background",
        type = "bool",
        path = "auto_background",
    },
    {
        name = "day_brightness",
        label = "Day brightness",
        group = "Background",
        type = "select",
        options = FRACTIONS,
        path = "day_brightness",
    },
    { name = "cache", label = "Cache highlights", group = "Background", type = "bool", path = "cache" },
    -- ── Focus ───────────────────────────────────────────────────────────────
    { name = "dim_inactive", label = "Dim inactive windows", group = "Focus", type = "bool", path = "dim_inactive" },
    {
        name = "dim_inactive_amount",
        label = "Dim strength",
        group = "Focus",
        type = "select",
        options = FRACTIONS,
        path = "dim_inactive_amount",
    },
    { name = "dark_active", label = "Darken active window", group = "Focus", type = "bool", path = "dark_active" },
    {
        name = "dark_active_amount",
        label = "Darken active strength",
        group = "Focus",
        type = "select",
        options = FRACTIONS,
        path = "dark_active_amount",
    },
    -- ── Syntax ──────────────────────────────────────────────────────────────
    {
        name = "comments_italic",
        label = "Italic comments",
        group = "Syntax",
        type = "bool",
        path = "styles.comments",
        italic = true,
    },
    {
        name = "keywords_italic",
        label = "Italic keywords",
        group = "Syntax",
        type = "bool",
        path = "styles.keywords",
        italic = true,
    },
    {
        name = "functions_italic",
        label = "Italic functions",
        group = "Syntax",
        type = "bool",
        path = "styles.functions",
        italic = true,
    },
}

--- Read a dot-path value out of a (possibly nested) table.
---@param tbl table
---@param path string
---@return any
local function get_path(tbl, path)
    for key in path:gmatch("[^.]+") do
        if type(tbl) ~= "table" then
            return nil
        end
        tbl = tbl[key]
    end
    return tbl
end

--- Build a nested override table representing `path = value`.
---@param path string
---@param value any
---@return table
local function nest(path, value)
    local root = {}
    local cursor = root
    local parts = vim.split(path, ".", { plain = true })
    for i, key in ipairs(parts) do
        if i == #parts then
            cursor[key] = value
        else
            cursor[key] = {}
            cursor = cursor[key]
        end
    end
    return root
end

--- The override value a spec contributes for `value` (encodes the italic toggle).
---@param spec lvim-colorscheme.Setting
---@param value any
---@return any
local function encode(spec, value)
    if spec.italic then
        -- Set italic explicitly (not an empty table): `tbl_deep_extend` MERGES, so `{}` would
        -- not clear an existing `italic = true` — toggling off must write `italic = false`.
        return { italic = value == true }
    end
    return value
end

--- Whether `value` for `spec` can't actually apply in the current config (so the panel marks
--- it dimmed + struck through). Evaluated at render time, so it tracks the transparent toggle.
---@param spec lvim-colorscheme.Setting
---@param value any
---@return boolean
function M.value_disabled(spec, value)
    local opts = config.options or config.defaults
    -- "transparent" sidebar/float only renders see-through while global `transparent` is on;
    -- otherwise it inherits the opaque editor bg → inert.
    if (spec.path == "styles.sidebars" or spec.path == "styles.floats") and value == "transparent" then
        return not opts.transparent
    end
    -- `dark_active` darkens the active window's bg; with global `transparent` on Normal is NONE
    -- (nothing to darken) → inapplicable, whatever the value.
    if spec.path == "dark_active" then
        return opts.transparent == true
    end
    -- The darken STRENGTH is inert when transparent is on (as above) OR when the `dark_active`
    -- toggle itself is off — there is no active-window darkening to size.
    if spec.path == "dark_active_amount" then
        return opts.transparent == true or opts.dark_active ~= true
    end
    -- The dim STRENGTH only matters while `dim_inactive` is on.
    if spec.path == "dim_inactive_amount" then
        return opts.dim_inactive ~= true
    end
    return false
end

--- Current effective value of a setting, decoded to its panel form.
---@param spec lvim-colorscheme.Setting
---@return any
function M.get(spec)
    local opts = config.options or config.defaults
    local raw = get_path(opts, spec.path)
    if spec.italic then
        return type(raw) == "table" and raw.italic == true
    end
    -- A "transparent" sidebar/float that can't apply RENDERS as the editor bg (= "normal"), so
    -- report that — re-opening reflects reality. Other disabled cases (e.g. dark_active) have no
    -- effective equivalent: they keep their real value and are simply shown struck through.
    if
        (spec.path == "styles.sidebars" or spec.path == "styles.floats")
        and raw == "transparent"
        and not opts.transparent
    then
        return "normal"
    end
    return raw
end

--- Apply a new value live (via lvim-colorscheme.set) and persist it.
---@param spec lvim-colorscheme.Setting
---@param value any
---@param persist? boolean  default true; false while restoring FROM the store
function M.set(spec, value, persist)
    require("lvim-colorscheme").set(nest(spec.path, encode(spec, value)))
    if persist ~= false then
        store.save(spec.name, value)
    end
end

--- Restore persisted values into the live config. The store wins over setup() defaults;
--- keys absent from the store are left untouched. Applied in ONE `set` call (one reload).
--- Call once after `config.setup`.
function M.restore()
    local names = {}
    for _, s in ipairs(M.specs) do
        names[#names + 1] = s.name
    end
    -- Seed control-center's DB from a standalone JSON file the first time they cohabit.
    store.migrate(names)

    local overrides = {}
    for _, spec in ipairs(M.specs) do
        local v = store.load(spec.name)
        if v ~= nil then
            overrides = vim.tbl_deep_extend("force", overrides, nest(spec.path, encode(spec, v)))
        end
    end
    if next(overrides) then
        require("lvim-colorscheme").set(overrides)
    end
end

return M
