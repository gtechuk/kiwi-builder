FROM opensuse:42.3

# Add repo to get latest version of kiwi (otherwise can't use with schema version 6.7+)
RUN zypper --non-interactive --gpg-auto-import-keys addrepo -f http://download.opensuse.org/repositories/Virtualization:/Appliances:/Builder/openSUSE_Leap_42.3/Virtualization:Appliances:Builder.repo

# Install everything we need
RUN zypper --non-interactive --no-gpg-checks refs \
    && zypper --non-interactive --no-gpg-checks refresh \
    && zypper --non-interactive --no-gpg-checks install -y -f which python3-kiwi=9.15.3 jing gfxboot debootstrap dpkg checkmedia syslinux git \
    && kiwi-ng --version

WORKDIR /root

# Clone kiwi examples
RUN git clone https://github.com/SUSE/kiwi-descriptions.git

# Add run script
COPY run.sh /run.sh

VOLUME [ "/out" ]

# Default to builder the Suse Leap 42.3 JeOS Example
CMD [ "/run.sh", "/root/kiwi-descriptions/suse/x86_64/suse-leap-42.3-JeOS", "oem" ]
