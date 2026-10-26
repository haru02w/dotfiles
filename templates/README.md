# Templates

Project scaffolds exposed as flake templates by
[`modules/flake/templates.nix`](../modules/flake/templates.nix). See the
[main README](../README.md#dev-templates) for usage.

> [!IMPORTANT]
> Pick the right dependency list in a template's `flake.nix`:
>
> - **buildInputs**: dependencies that should exist in the runtime environment.
> - **propagatedBuildInputs**: dependencies that should exist in the runtime
>   environment and also be propagated to downstream runtime environments.
> - **nativeBuildInputs**: dependencies that should only exist in the build
>   environment.
> - **propagatedNativeBuildInputs**: dependencies that should only exist in the
>   build environment and also be propagated to downstream build environments.
