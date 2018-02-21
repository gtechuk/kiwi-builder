# Kiwi Builder

Docker container for building ISO OS Images with Kiwi.

By default the image builds one of the Kiwi Leap JeOS 42.3 example.

## Run

To create an ISO from the Leap JeOS 42.3 example using docker-compose:

`docker-compose up --build`

To run with you own configuration, mount the directory containing you configuration
as a volume and provide the path to the volume as the argument.

## Configuration

For documentation on configuring Kiwi images see https://suse.github.io/kiwi/overview/workflow.html

## Examples

Example Kiwi configuration files can be found here: https://github.com/SUSE/kiwi-descriptions

Of the ones tried with this repo's docker build, only https://github.com/SUSE/kiwi-descriptions/tree/master/suse/x86_64/suse-leap-42.3-JeOS
built an ISO successfully (that could be booted and logged into).

## Burning Image

UEFI is configured with the type[firmware] attribute in the config.xml (UEFI enabled images may not work with non-UEFI hardware).

The UEFI image can be burnt to USB using https://etcher.io/ (or similar).