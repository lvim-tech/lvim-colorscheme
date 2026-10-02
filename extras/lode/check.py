#!/usr/bin/env python3
"""Measure the generated lode themes and REPORT. This script does not gate.

It used to fail a theme whose foregrounds did not clear WCAG AA. That was right
for every other target in `extra/` and wrong for this one, and the reason is in
the generator's header: a lode theme is not derived from the palette, it is
COPIED from lvim-colorscheme's resolved highlight groups. `text.primary` is
`Normal.fg`, at whatever contrast the editor has it — `#5e8888` on `#20272b`,
3.86:1, on base dark. An editor's body text under syntax highlighting is not a
web page's, and a client that sits beside the editor all day has to be the same
colour as the editor.

So the pairs below 4.5:1 are the editor's own and are not faults. They are
printed, because knowing which they are is useful and discovering them by
squinting is not, and the exit code is 0 either way.

What WOULD be a fault — a role missing, a value that is not a colour, a theme
whose `dark` disagrees with its own style name — still fails, because those are
bugs in the generator rather than decisions about contrast.

    python3 extras/lode/check.py          # every theme, summary only
    python3 extras/lode/check.py -v       # every measured pair, per theme
"""

import pathlib
import re
import sys

HERE = pathlib.Path(__file__).resolve().parent

# The AA threshold, used as a REPORTING line and nothing else.
AA = 4.5


def luminance(hex_color: str) -> float:
    h = hex_color.strip().lstrip("#")
    r, g, b = (int(h[i : i + 2], 16) for i in (0, 2, 4))

    def chan(v: int) -> float:
        x = v / 255
        return x / 12.92 if x <= 0.03928 else ((x + 0.055) / 1.055) ** 2.4

    return 0.2126 * chan(r) + 0.7152 * chan(g) + 0.0722 * chan(b)


def contrast(a: str, b: str) -> float:
    la, lb = luminance(a), luminance(b)
    hi, lo = max(la, lb), min(la, lb)
    return (hi + 0.05) / (lo + 0.05)


def parse(path: pathlib.Path) -> dict[str, dict[str, str]]:
    """A minimal TOML reader: these files are flat `key = "value"` under `[table]`."""
    out: dict[str, dict[str, str]] = {"": {}}
    table = ""
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("["):
            table = line.strip("[]")
            out.setdefault(table, {})
            continue
        m = re.match(r'^([A-Za-z_][\w]*)\s*=\s*"?([^"]*)"?\s*$', line)
        if m:
            out[table][m.group(1)] = m.group(2)
    return out


# Every ink the client paints, and the surface it is painted on. These are the
# pairs the application actually produces — not every combination that could be
# written, which would report pairs nobody ever sees.
def pairs(t: dict[str, dict[str, str]]) -> list[tuple[str, str, str]]:
    s, text, accent, grid = t["surface"], t["text"], t["accent"], t["grid"]
    syntax = t.get("syntax", {})
    out: list[tuple[str, str, str]] = []

    for surface_name in ("base", "panel", "raised", "overlay", "status", "hover"):
        bg = s.get(surface_name)
        if not bg:
            continue
        out.append((f"text.primary on surface.{surface_name}", text["primary"], bg))
        out.append((f"text.muted on surface.{surface_name}", text["muted"], bg))
    out.append(("text.title on surface.panel", text.get("title", text["muted"]), s["panel"]))
    out.append(("text.inverted on accent.primary", text["inverted"], accent["primary"]))

    for k in ("primary", "secondary", "success", "warning", "error", "info"):
        out.append((f"accent.{k} on surface.status", accent[k], s["status"]))
        out.append((f"accent.{k} on surface.panel", accent[k], s["panel"]))

    for k in ("keyword", "string", "number", "comment", "function", "operator", "identifier"):
        if k in syntax:
            out.append((f"syntax.{k} on surface.base", syntax[k], s["base"]))

    out.append(("grid.header_fg on grid.header_bg", grid["header_fg"], grid["header_bg"]))
    out.append(("grid.selection_fg on grid.selection_bg", grid["selection_fg"], grid["selection_bg"]))
    out.append(("grid.null_fg on surface.base", grid["null_fg"], s["base"]))
    out.append(("grid.null_fg on grid.row_alt", grid["null_fg"], grid["row_alt"]))
    if "line_nr" in grid:
        out.append(("grid.line_nr on surface.base", grid["line_nr"], s["base"]))
    out.append(("text.primary on grid.row_alt", text["primary"], grid["row_alt"]))
    return out


REQUIRED = {
    "surface": ("base", "panel", "raised", "overlay", "status", "hover", "selected", "border"),
    "text": ("primary", "muted", "title", "inverted"),
    "accent": ("primary", "secondary", "success", "warning", "error", "info"),
    "grid": ("header_bg", "header_fg", "row_alt", "selection_bg", "selection_fg", "null_fg", "line_nr"),
}

HEX = re.compile(r"^#[0-9A-Fa-f]{6}$")


def structural_faults(path: pathlib.Path, t: dict[str, dict[str, str]]) -> list[str]:
    """The things that ARE bugs: a missing role, a non-colour, a wrong `dark`."""
    bad: list[str] = []
    for table, keys in REQUIRED.items():
        if table not in t:
            bad.append(f"[{table}] is missing entirely")
            continue
        for k in keys:
            v = t[table].get(k)
            if v is None:
                bad.append(f"{table}.{k} is missing")
            elif not HEX.match(v):
                bad.append(f"{table}.{k} = {v!r} is not #rrggbb")
    root = t.get("", {})
    style = root.get("style", "")
    dark = root.get("dark", "")
    if style:
        want = "false" if style.endswith("_light") else "true"
        if dark != want:
            bad.append(f"dark = {dark!r} disagrees with style {style!r}")
    if root.get("name", "") != path.stem:
        bad.append(f"name = {root.get('name')!r} does not match the file name {path.stem!r}")
    return bad


def main() -> int:
    verbose = "-v" in sys.argv or "--verbose" in sys.argv
    files = sorted(HERE.glob("*.toml"))
    if not files:
        print("no theme files — run `scripts/build lode` first", file=sys.stderr)
        return 1

    broken = 0
    total_below = 0
    worst_overall = ("", 99.0, "")
    for f in files:
        t = parse(f)
        faults = structural_faults(f, t)
        if faults:
            broken += 1
            print(f"BROKEN {f.name}")
            for x in faults:
                print(f"         {x}")
            continue

        measured = [(label, contrast(fg, bg), fg, bg) for label, fg, bg in pairs(t)]
        below = [m for m in measured if m[1] + 1e-9 < AA]
        total_below += len(below)
        worst = min(measured, key=lambda m: m[1])
        if worst[1] < worst_overall[1]:
            worst_overall = (f.stem, worst[1], worst[0])

        print(f"ok     {f.name}   {len(below)}/{len(measured)} pair(s) under {AA}, lowest {worst[1]:.2f} ({worst[0]})")
        if verbose:
            for label, ratio, fg, bg in measured:
                mark = "  " if ratio >= AA else "<<"
                print(f"       {mark} {ratio:5.2f}  {label}  ({fg} on {bg})")
        elif below:
            for label, ratio, fg, bg in below[:4]:
                print(f"       << {ratio:5.2f}  {label}  ({fg} on {bg})")
            if len(below) > 4:
                print(f"       … and {len(below) - 4} more (run with -v)")

    print()
    print(f"{len(files)} theme(s), {broken} structurally broken, {total_below} pair(s) under {AA} in all")
    if worst_overall[0]:
        print(f"lowest anywhere: {worst_overall[1]:.2f} — {worst_overall[2]} in {worst_overall[0]}")
    print(
        "\nA pair under the line is NOT a failure here. These themes are copied from the editor's\n"
        "own highlight groups and are meant to read exactly as the editor does; see the header of\n"
        "lua/lvim-colorscheme/extra/misc/lode.lua. Only a structurally broken theme fails."
    )
    return 1 if broken else 0


if __name__ == "__main__":
    sys.exit(main())
