# gitlabenv

A small utility to export the GitLab environment variable of a project in your
shell. 

Useful if you want to debug stuff in the context of your CI.

## Build & Run

First you will need to install [Crystal][installation].

After having cloned the repository, run:
```
$ make build
```

This should build everything then you can find the tool in the `bin/` folder.

[installation](https://crystal-lang.org/reference/installation/)

## Usage

Printing the variable in the output:
```
$ export GITLAB_TOKEN=<your gitlab token>
$ export GITLAB_HOST=<your gitlab host>
$ gitlabenv path/to/my/project
export VAR=VALUE
...
```

Storing them in a file and loading them in our shell:
```
$ gitlabenv path/to/my/project > gitlabenv.sh
$ source gitlabenv.sh
```

Loading them directly in our shell without temp file:
```
$ source <(gitlabenv path/to/my/project)
```

## Development

Create an `.env.sh` file to hold your `GITLAB_TOKEN` and `GITLAB_HOST`.
You can copy the example with:
```
$ make setup-env
```

Then you have to modify its content to match your host and token.

Now let's

Hack on it:
```
*hack* *hack* *hack*
```

Build it:
```
$ make build
```

Run it (loading your env automatically):
```
$ make run id="path/to/my/project"
```

### .env.sh tip

Use a password available via the CLI to store your token, then you can do:
```
export GITLAB_TOKEN=`pass mygitlabtoken`
```

This will ensure that you don't ever put sensitive data directly in the file.
Avoiding accidental leaking of information, and it will only be loaded in the
environment of the temporary make shell, it will not clutter your current
shell.

## Contributing

1. Fork it (<https://github.com/Mayeu/gitlabenv/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Mayeu](https://github.com/Mayeu) - creator and maintainer
