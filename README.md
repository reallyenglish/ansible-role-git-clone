# ansible-role-git-clone

A simple wrapper of `ansible` `git` module to clone repositories.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `git_clone_repositories` | list of repositories to clone (see below) | `[]` |

## `git_clone_repositories`

This is a list of dict. Keys are a subset of parameters of `ansible` `git`
module. Supported parameters are:

* `accept_hostkey`
* `dest`
* `force`
* `recursive`
* `remote`
* `repo`
* `track_submodules`
* `umask`
* `update`
* `version`

Additionally, the following keys are supported in the table below.

| Key | Description | Mandatory? |
|-----|-------------|------------|
| `user` | user name to clone as | no |
| `state` | state of the repository, either `present` or `absent` | yes |

# Dependencies

* [`ansible-role-git`](https://github.com/reallyenglish.com/ansible-role-git)

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-git-clone
  pre_tasks:
    - file:
        path: /usr/local/git_clone/bin
        owner: bin
        state: directory
  vars:
    url: https://github.com/reallyenglish/ansible-role-example
    git_clone_repositories:
      - repo: "{{ url }}"
        dest: /usr/local/git_clone/ansible-role-example
        state: present
      - repo: "{{ url }}"
        dest: /usr/local/git_clone/update
        update: yes
        state: present
      - repo: "{{ url }}"
        dest: /usr/local/git_clone/bin/repo
        user: bin
        state: present
      - repo: "{{ url }}"
        dest: /usr/local/git_clone/umask
        umask: 002
        state: present
```

# License

```
Copyright (c) 2017 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [qansible](https://github.com/trombik/qansible)
