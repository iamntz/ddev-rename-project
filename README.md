## Installation:

For DDEV v1.23.5 or above run

```sh
ddev add-on get iamntz/ddev-rename-project
```

For earlier versions of DDEV run

```sh
ddev get iamntz/ddev-rename-project
```

## Usage:

```sh
ddev rename-project my-new-project
```

## Notes:

The command will create a new DB snapshot, it will remove your current project, will create a new project and finally it will import the newly created DB snapshot.