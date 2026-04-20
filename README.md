# git-all

`git-all` is a single-file command-line tool written in Python 3 for viewing the status of multiple local Git repositories.

## Features

Sample output:

```text
repo-a   dirty        ahead 2   behind 0
repo-b   clean        ahead 0   behind 3
repo-c   no-upstream
repo-d   dirty        ahead 1   behind 4
```

- `dirty` is displayed in red
- `clean` is displayed in green
- `no-upstream` is displayed in yellow
- Colors are automatically disabled when output is redirected or piped

## Usage

```bash
git-all [PATH]
git-all -A [PATH]
git-all --version
```

- Default behavior
  - Only show repositories with `dirty` or `no-upstream` status
- `-A`, `--all`
  - Show all repositories, including `clean`
- `PATH`
  - Optional scan directory
  - If omitted: defaults to `~/Workdir` if it exists, otherwise the current directory
- `--version`
  - Show version information

## Scan Rules

- Recursively scans `PATH` and its subdirectories for Git repositories
- If the scan root itself is a Git repository, it is included in the output
- Once a repository is found, its internal directories are not scanned further to avoid duplicates
- Repository names in the output are shown as paths relative to the scan root

## Installation

Install via curl:

```bash
curl -fsSL https://raw.githubusercontent.com/zhanglongx/git-all/refs/heads/main/install.sh | bash
```

Install location:

```text
/usr/local/bin/git-all
```

Alternatively, clone the repository and run directly:

```bash
chmod +x git-all
./git-all --version
```
