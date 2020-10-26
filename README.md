# mma-docker-java8-mvn
base docker image with java8 and maven

Docker image with java8 and maven. Not intended to use as a base for java projects, just for building.

## Usage

This image is to be used to build your app using maven.

Contents of .drone.yml:
```
steps:
- name: build
  image: quay.io/ukhomeofficedigital/mma-java8-mvn:v0.0.1
  environment:
    ARTIFACTORY_USERNAME:
      from_secret: artifactory_username
    ARTIFACTORY_PASSWORD:
      from_secret: artifactory_password
  commands:
    - "mvn clean install"
  when:
    event:
    - push
    - pull_request

```

To deploy artifacts to Artifactory, please pass valid credentials via the ARTIFACTORY\_USERNAME and ARTIFACTORY\_PASSWORD environment variables.

You'll also need to include the following in your POM file:
```
<distributionManagement>
        <repository>
                <id>artifactory</id>
                <name>libs-release-local</name>
                <url>https://artifactory.digital.homeoffice.gov.uk/artifactory/libs-release-local</url>
        </repository>
        <snapshotRepository>
                <id>artifactory</id>
                <name>libs-snapshot-local</name>
                <url>https://artifactory.digital.homeoffice.gov.uk/artifactory/libs-snapshot-local</url>
        </snapshotRepository>
</distributionManagement>
```
Maven should then deploy to Artifactory during the "deploy" lifecycle phase.

## License

This project is licensed under the GPL v2 License - see the
[LICENSE.md](https://github.com/UKHomeOffice/mma-docker-java8-mvn/blob/master/LICENSE) file for details
