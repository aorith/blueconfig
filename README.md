# Fedora Silverblue configuration

> Configuration for my daily work machine running Silverblue.

Silverblue setup using [OSTree native containers](https://coreos.github.io/rpm-ostree/container/), the [post-install](post-install) playbook and scripts are only required after the first install.

**This is an opinionated build that probably won't suit your needs.**

## How to install

To rebase an existing Silverblue/Kinoite machine to the latest release:

1. Download and install [Fedora Silverblue](https://silverblue.fedoraproject.org/download)
1. After you reboot you should [pin the working deployment](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) so you can safely rollback
1. Open a terminal and use one of the following commands to rebase the OS:

```
sudo bootc switch ostree-unverified-registry:ghcr.io/aorith/blueconfig:stable
```

Check [post-install](post-install) for the _post-install_ instructions.

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/aorith/blueconfig

If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign. The public key can be in your public repo (your users need it to check the signatures), and you can paste the private key in Settings -> Secrets -> Actions.

## Local testing

This is for easy testing on a VM.

```sh
# Run a local registry
podman run --rm -p 5000:5000 registry:2

# Build the image
podman build . -t localhost:5000/blueconfig

# Push the image
podman push --tls-verify=false localhost:5000/blueconfig
```

On the VM create the file `/etc/containers/registries.conf.d/local.conf:

```conf
[[registry]]
location = "<host IP>:5000"
insecure = true
```

Then rebase:

```sh
sudo bootc switch ostree-unverified-registry:HOST_IP:5000/blueconfig:latest
```
