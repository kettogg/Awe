self: super: {
  # Corner radius = 0 for materia-theme
  materia-theme = super.materia-theme.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      ../patches/materia.diff
    ];
  });
}

