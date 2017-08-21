# circleci-golang-node-image
Fork of circleci/golang [Docker image](https://github.com/circleci/circleci-images/blob/master/shared/images/Dockerfile-basic.template) to install `node`.

[Docker hub](https://hub.docker.com/r/vihervas/circleci-golang-node/)

## Example

`.circleci/config.yml`:
```yaml
version: 2
jobs:
  build:
    docker:
      - image: vihervas/circleci-golang-node:1.8.3-6.11.2
    working_directory: /go/src/<path-to-go-repo>
    steps:
      - run: go version     # 1.8.3
      - run: node --version # v6.11.2
      - run: npm --version  # 3.10.10

``` 

## License
[MIT](LICENSE)
