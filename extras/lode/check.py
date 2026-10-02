#!/usr/bin/env python3
"""Re-measure every generated lode theme against the floors the generator promises.

The generator (lua/lvim-colorscheme/extra/misc/lode.lua) grounds each foreground
against the surface it is actually drawn on. This checks that independently, in a
second implementation of the WCAG formula, so a mistake in the Lua would have to
be made twice to go unnoticed.

The floors are the generator's own, and the reasons are in its header:

  text.primary      4.5  on the hardest of panel / base / raised / overlay / header_bg
  text.muted        3.2  on the same five
  text.inverted     3.0  on accent.primary                         (badge ink; the shared
                         family value, which an accent can cap — see util.title_fg)
  accent.*          3.0  on the hardest of panel / base / raised   (UI components, not body text)
  syntax.*          4.5  on base                                   (the editor's one surface)
  syntax.comment    3.2  on base
  grid.header_fg    4.5  on grid.header_bg
  grid.selection_fg 4.5  on grid.selection_bg
  grid.null_fg      3.0  on base and on grid.row_alt

Surfaces are checked for being DISTINGUISHABLE rather than readable: panel, raised
and overlay must each be at least 1.10 from base, and row_alt deliberately is NOT
(it is a stripe — see the generator's note 3), so it is checked for the opposite:
present but under 1.15.

Exit code is non-zero if any theme fails.
"""

import pathlib
import re
import sys

HERE = pathlib.Path(__file__).resolve().parent


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


def hardest(text: str, surfaces: list[str]) -> str:
    """The surface a colour has the hardest time on: the nearest in luminance.

    Same rule as util.hardest. A colour floored against that one clears them all,
    and which surface is the hard one genuinely depends on the palette.
    """
    lum = luminance(text)
    return min(surfaces, key=lambda s: abs(luminance(s) - lum))


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


def check(path: pathlib.Path) -> list[str]:
    t = parse(path)
    s, text, accent, grid = t["surface"], t["text"], t["accent"], t["grid"]
    syntax = t.get("syntax", {})
    fails: list[str] = []

    def need(label: str, fg: str, bg: str, floor: float) -> None:
        got = contrast(fg, bg)
        if got + 1e-9 < floor:
            fails.append(f"{label}: {got:.2f} < {floor} ({fg} on {bg})")

    ink_surfaces = [s["panel"], s["base"], s["raised"], s["overlay"], grid["header_bg"]]
    need("text.primary", text["primary"], hardest(text["primary"], ink_surfaces), 4.5)
    need("text.muted", text["muted"], hardest(text["muted"], ink_surfaces), 3.2)

    # The badge ink is the FAMILY's shared value and an accent caps what any ink on
    # it can reach, so this is checked at the UI-component floor the family itself
    # settled on rather than at 4.5 — see util.title_fg's own note.
    #
    # It is checked on accent.primary ALONE, because that is the only surface the
    # generator grounds it against and therefore the only one lode is allowed to
    # paint it on. An earlier version of this check also tested it on the grid
    # selection; 40 of the 48 styles failed, and the answer was not a different
    # ink — the selection has its own grounded pair (selection_bg/selection_fg)
    # and the client had no business writing inverted ink there.
    need("text.inverted on accent", text["inverted"], accent["primary"], 3.0)

    acc_surfaces = [s["panel"], s["base"], s["raised"]]
    for k in ("primary", "secondary", "success", "warning", "error", "info"):
        need(f"accent.{k}", accent[k], hardest(accent[k], acc_surfaces), 3.0)

    for k, floor in (
        ("keyword", 4.5),
        ("string", 4.5),
        ("number", 4.5),
        ("function", 4.5),
        ("operator", 4.5),
        ("identifier", 4.5),
        ("comment", 3.2),
    ):
        if k in syntax:
            need(f"syntax.{k}", syntax[k], s["base"], floor)

    need("grid.header_fg", grid["header_fg"], grid["header_bg"], 4.5)
    need("grid.selection_fg", grid["selection_fg"], grid["selection_bg"], 4.5)
    need("grid.null_fg on base", grid["null_fg"], s["base"], 3.0)
    need("grid.null_fg on row_alt", grid["null_fg"], grid["row_alt"], 3.0)

    # Surfaces: three places have to look like three places.
    for k in ("panel", "raised", "overlay"):
        got = contrast(s[k], s["base"])
        if got < 1.10:
            fails.append(f"surface.{k} is not a place: {got:.3f} from base")
    # …and the stripe deliberately is NOT a place.
    stripe = contrast(grid["row_alt"], s["base"])
    if stripe < 1.01:
        fails.append(f"grid.row_alt is invisible: {stripe:.3f} from base")
    if stripe > 1.15:
        fails.append(f"grid.row_alt is a second background: {stripe:.3f} from base")

    return fails


def main() -> int:
    files = sorted(HERE.glob("*.toml"))
    if not files:
        print("no theme files — run `scripts/build lode` first", file=sys.stderr)
        return 1
    bad = 0
    for f in files:
        fails = check(f)
        if fails:
            bad += 1
            print(f"FAIL {f.name}")
            for x in fails:
                print(f"       {x}")
        else:
            print(f"ok   {f.name}")
    print(f"\n{len(files)} theme(s), {bad} failing")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
