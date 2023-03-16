Fedora Silverblue configuration
===

> Configuration for my daily work machine running Silverblue.  

This is based on https://coreos.github.io/rpm-ostree/, an image is built nightly, the [post-install](post-install) configuration is only required on the first install.  

## How to install

To rebase an existing Silverblue/Kinoite machine to the latest release: 

1. Download and install [Fedora Silverblue](https://silverblue.fedoraproject.org/download)
1. After you reboot you should [pin the working deployment](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) so you can safely rollback 
1. Open a terminal and use one of the following commands to rebase the OS:

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/aorith/blueconfig:latest

Check [post-install](post-install) for the *post-install* instructions.  

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/aorith/blueconfig

If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign. The public key can be in your public repo (your users need it to check the signatures), and you can paste the private key in Settings -> Secrets -> Actions.
