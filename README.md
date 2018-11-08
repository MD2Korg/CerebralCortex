# CerebralCortex-DockerCompose

Cerebral Cortex is the big data cloud companion of mCerebrum designed to support population-scale data analysis, visualization, model development, and intervention design for mobile sensor data.

Start using Cerebral Cortex with Docker

You can find more information about MD2K software on our [software website](https://md2k.org/software) or the MD2K organization on our [MD2K website](https://md2k.org/).

## Install
#### Setup environment
Minimum requirements:
* Any Debian Linux Distro (We have tested it on Centos, Linux Mint, KDE, and Ubuntu)

#### Clone and configure CerebralCortex-DataAnalysis
* clone https://github.com/MD2Korg/CerebralCortex-DockerCompose.git
* Execute following commands to run/setup environment:
    * `cd CerebralCortex-DockerCompose`
    * `docker-compose create`
    * `docker-compose up -d`
* Once the system is up and running, you would need to manually run influxdb commands inside the contains.
    * `docker-compose exec influxdb influx (command to connect to influxdb container)`
    * Please copy and run [influxdb init setup](https://github.com/MD2Korg/CerebralCortex-DockerCompose/blob/master/influxdb/init.txt)
* Note: please modify [docker-compose-yaml](https://github.com/MD2Korg/CerebralCortex-DockerCompose/blob/master/docker-compose.yml) to change ports and other settings.

## Contributing
Please read our [Contributing Guidelines](https://md2k.org/contributing/contributing-guidelines.html) for details on the process for submitting pull requests to us.

We use the [Python PEP 8 Style Guide](https://www.python.org/dev/peps/pep-0008/).

Our [Code of Conduct](https://md2k.org/contributing/code-of-conduct.html) is the [Contributor Covenant](https://www.contributor-covenant.org/).

Bug reports can be submitted through [JIRA](https://md2korg.atlassian.net/secure/Dashboard.jspa).

Our discussion forum can be found [here](https://discuss.md2k.org/).

## Versioning

We use [Semantic Versioning](https://semver.org/) for versioning the software which is based on the following guidelines.

MAJOR.MINOR.PATCH (example: 3.0.12)

  1. MAJOR version when incompatible API changes are made,
  2. MINOR version when functionality is added in a backwards-compatible manner, and
  3. PATCH version when backwards-compatible bug fixes are introduced.

For the versions available, see [this repository's tags](https://github.com/MD2Korg/CerebralCortex-DockerCompose/tags).

## Contributors

Link to the [list of contributors](https://github.com/MD2Korg/CerebralCortex-DockerCompose/graphs/contributors) who participated in this project.

## License

This project is licensed under the BSD 2-Clause - see the [license](https://md2k.org/software-under-the-hood/software-uth-license) file for details.

## Acknowledgments

* [National Institutes of Health](https://www.nih.gov/) - [Big Data to Knowledge Initiative](https://datascience.nih.gov/bd2k)
  * Grants: R01MD010362, 1UG1DA04030901, 1U54EB020404, 1R01CA190329, 1R01DE02524, R00MD010468, 3UH2DA041713, 10555SC
* [National Science Foundation](https://www.nsf.gov/)
  * Grants: 1640813, 1722646
* [Intelligence Advanced Research Projects Activity](https://www.iarpa.gov/)
  * Contract: 2017-17042800006

