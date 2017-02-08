git-sync
========

A small docker container that automatically mirrors a directory to an ephemeral
git repository. Changes are synced to a git repository exposed via [Gitweb][1].
Using [modd][2], the repository will be automatically committed and pushed to
the git repository as you make them.

Usage
-----

From the directory you want to expose, run:

    docker run -v $(pwd):/src -p 1234:80 timothyb89/git-sync:latest

Gitweb should then be available at http://localhost:1234/ with your working
directory mirrored to the `sync.git` project. The URLs shown in the project
summary should be accessible to any other containers on your local network,
including containers being built.

Why?
----
Docker [can't mount volumes during builds][3], which is inconvenient if you want
to, for example, build a container from uncommitted code in your working
directory. However, Docker builds *can* access resources on the network.

This container makes your changes immediately available in the form of a git
repository, allowing Dockerfiles that clone git repositories to consume your
working directory with little to no modification. If you can specify a
repository and branch using [`--build-arg`][4], this will allow you to build
a container from your local tree with no changes needed.


[1]: https://git.wiki.kernel.org/index.php/Gitweb
[2]: https://github.com/cortesi/modd
[3]: https://github.com/docker/docker/issues/14080
[4]: https://docs.docker.com/engine/reference/builder/#arg
