# cargo-deb Runner

[![Tests Status](https://github.com/sanders41/cargo-deb-runner/actions/workflows/testing.yml/badge.svg?branch=main&event=push)](https://github.com/sanders41/cargo-deb-runner/actions?query=workflow%3ATesting+branch%3Amain+event%3Apush)

This Docker image builds `deb` packages from Rust projects using
[cargo-deb](https://github.com/kornelski/cargo-deb).

## Usage

### Build the image

```sh
docker build -t cargo-deb-runner .
```

### Creating the `deb` package

To build the `deb` package run the docker image from within the root directory of the Rust project,
mounting the directory as a volume. This will create the `deb` package in the `target/debian`
directory.

```sh
docker run --rm -v ${PWD}:/builder cargo-deb-runner
```

Command like flags can also be passed to the build. For example, by default `cargo-deb` appends a
`-1` post tag to the version of the package. To exclude this set the `deb-revision` flag.

```sh
docker run --rm -v ${PWD}:/builder cargo-deb-runner --deb-revision=""
```
