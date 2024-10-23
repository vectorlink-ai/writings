# VectorLink.ai - writings

This repository contains different blog posts, articles, tutorials, etc. Since we publish on our website, we can't make this repository public without hurting SEO.

## Structure

Under `entries/`, each directory is its own group of articles, blog posts, etc, which might share common assets. Each .md file is an individual article.

## Formatting

For now, we use prettier for markdown formatting. This repository contains a top-level `.prettierrc`, which sane editors with prettier integration should just be able to pick up on. Make sure you use something that auto-formats on save, or at least before you commit.

## Development shell

This repository comes with a default development shell through `flake.nix`. This is intended to contain all tools needed in support of writing articles, such as formatters (prettier), plotting tools (gnuplot), or other tools with wide applicability. Feel free to add to this, and make sure that any tool used is actually part of the dev shell so that it will run predictably on everyone's machine and in CI.

You can load this development shell through `nix develop`. You can also use `direnv` and its various IDE integrations to automatically load the dev shell when interacting with this repository.

If a subdir needs some weird set of dependencies that clash with the repo-wide ones, feel free to define an extra dev shell besides the default one, and use that one in your subdir instead through a custom `.envrc`. In general though, we should try to keep our tool use consistent.
