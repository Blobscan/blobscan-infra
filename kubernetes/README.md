install helm
install helmfile (https://github.com/helmfile/helmfile/releases)
helmfile apply

git submodule update --init --recursive

We use feat/import branch from the chart, which supports import methods from another remote database.
