# Smallest Ruby Image for Docker

A Ruby image with most common build dependencies installed to compile native GEMs. It is only 329.7 MB  and is optimized for minimum overhead, while including all required dependencies for common GEMs like nokogiri, curb or mysql2. The base image is a minimal Ubuntu 14.04 which makes it easy and flexible to install more exotic Ruby apps.

#### Image Name

````
cloudgear/ruby:2.2
````

Other variations and version are described below.

#### Quick Usage

````
$ docker run -it cloudgear/ruby:2.2 ruby -e 'puts "Hello small Ruby image with version #{RUBY_VERSION}"'
Hello small Ruby image with version 2.2.0
````

## Image Size

This image is only **329.7 MB** and contains most common build dependencies. Additionally, the image is based on a normal Ubuntu 14.04 base image and therefore most of your applications should install without problems.

We have looked at more exotic Linux distributions with even smaller base images. But when installing common dependencies required for Ruby GEMs, these images result in similar sizes, sometimes even larger. And having an Ubuntu based image makes life often easier as documentation and common knowledge is far better.

If your application does not require build dependencies, the `minimal` image version can be used, which is only **222.7 MB**.

### Comparison to Similar Images

Similar images are more than double the size of this image. We have researched popular Ruby images for Docker:

````
Semi-official Ruby image
ruby:2.2.0                  774.7 MB

Without build dependencies (native GEMs can't be compiled)
ruby:2.2.0-slim             299.3 MB

Atlas Health (only minimal build dependencies, libcurl & libxml)
atlashealth/ruby            347.2 MB
````

The semi-official Ruby-slim image is only 30 MB smaller but has no build dependencies included at all and hence all GEMs with native extension will fail to install. In contrast the minimal CloudGear Ruby image is only **222.7 MB**.


## What's Included in the Image?

The image comes in multiple variations and versions. For detailed information check the corresponding Dockerfiles in the [Github repository](https://github.com/cloudgear-images/ruby).

### Full Image

The image includes the specified Ruby version, the latest Rubygems and Bundler packages and common build dependencies. It is based on the `cloudgear/build-deps` image, [check it out](https://github.com/cloudgear-images/build-deps) for more details.

**Image name:** only version tags without any suffix, e.g. `cloudgear/ruby:2.2`

#### Tested GEMs

Most common GEMs with native extensions install fine, we have tested following GEMs:

* sqlite
* mysql2
* postgres (pg)
* nokogiri
* oj (json using native extension)
* curb
* unicorn
* puma

Please help us to test and support other GEMs with native extensions and report your problems as [Github issues](https://github.com/cloudgear-images/ruby/issues). Thanks.

### Onbuild Image

The same image as the full image but additional Dockerfile `ONBUILD` instructions allow the installation of your Bundler based Ruby application with a simple and empty Dockerfile.

**Image name:** tags with suffix `-onbuild`, e.g. `cloudgear/ruby:2.2-onbuild`

### Minimal Version

A minimal Ruby image is provided too. It includes Ruby, the latest Rubygems and Bundler packages and only minimal build dependencies. Most GEMs with native extensions fail to install. But as long as you don't depend on such GEMs you are fine with the `minimal` version. Additionally you can add required dependencies yourself to keep your application images as small as possible.

**Image name:** tags with suffix `-minimal`, e.g. `cloudgear/ruby:2.2-minimal`


## Usage

### Full Image

**Run IRB**

````
$ docker run -it cloudgear/ruby:2.2 irb
````

**Run a single Ruby command**

````
$ docker run cloudgear/ruby:2.2 ruby -e 'puts "A simple Ruby demo"'
A simple Ruby demo
````

**Dockerfile**

To build a custom image with some GEMs installed, create a Dockerfile:

````
FROM cloudgear/ruby:2.2

RUN gem install haml

ENTRYPOINT ["haml"]
````

### Onbuild Image

The onbuild image allows you to dockerize your Ruby applications with very little effort. You only need to create a Dockerfile within the root of your application with the following content:

````
FROM cloudgear/ruby:2.2-onbuild
CMD ["./your-script.rb"]
````

Yes, that's all! The requirement is, that your application comes with a `Gemfile` and `Gemfile.lock`. The `ONBUILD` triggers should work for most Ruby apps. The build copies the `Gemfile` and `Gemfile.lock`, runs `bundle install` and copies your application into `/usr/src/app`.

You can then build and run your application

````
docker build -t my-ruby-app .
docker run -it my-ruby-app
````

### Minimal Image

Running an IRB session or Ruby commands is the same as with the full image. If you wish to create an optimized Ruby image with specific build dependencies tailored for your application, you can create a Dockerfile. E.g. installing only the MySQL dependency:

````
FROM cloudgear/ruby:2.2-minimal

        
RUN apt-get update -q && apt-get install -yq --no-install-recommends \
        libmysqlclient-dev && \

    # clean up
    rm -rf /var/lib/apt/lists/* && \
    truncate -s 0 /var/log/*log

````

These will keep your images still very small and allows you to install GEMs with native extensions.

### Rails

CloudGear provides and optimized image for Rails based on this Ruby image. Please have a look at the [cloudgear-images/rails](https://github.com/cloudgear-images/rails) repository.


## Supported Tags

The image comes with multiple variations and supports the latest Ruby versions 2.1 and 2.2.

All variations and versions

* `cloudgear/ruby:2.1`
* `cloudgear/ruby:2.1-onbuild`
* `cloudgear/ruby:2.1-minimal`
* `cloudgear/ruby:2.2`
* `cloudgear/ruby:2.2-onbuild`
* `cloudgear/ruby:2.2-minimal`


## Contributing

We welcome contributions like new features, fixes, version bumps and other optimizations. Please create a pull request or in case of problems or questions file a [Github issue](https://github.com/cloudgear-images/ruby).

The image is configured as a Docker Automated Build and gets built and pushed to the Docker registry for every push.

## License

MIT License. Copyright 2015 CloudGear

![CloudGear Container Platform](https://www.cloudgear.net/img/logo-white.png)

A product by [CloudGear](https://www.cloudgear.net).
