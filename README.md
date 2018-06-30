Moloch for analzye pcap file using Vagrant and docker
-----------------------------------------------------

When you collect bunch of pcap files. And you need to analyze it.
Wireshark is the proper choice, but if you can use Moloch, it gives you more meaningful data.

Moloch is using Elasticsearch as database and providing you pcap collector, and viewer(not Kibana).
It sounds like complicate. This image helps you to make a moloch environment on your desktop using Vagrant and Docker

If you already have a docker environment, you don't need to use Vagrant. vagrant is for Windows Guy who doesn't have docker on Windows.


Installation
============

```
git clone vagrant-docker-moloch
cd vagrant-docker-moloch
vagrant up
```
