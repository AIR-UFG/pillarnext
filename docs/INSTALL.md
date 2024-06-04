# Installation

1. **Clone the repository and navigate to it:**

    ``` bash
    git clone https://github.com/qcraftai/pillarnext.git
    cd pillarnext
    ```

2. **Build the docker image:**

    ``` bash
    docker build -f docker/Dockerfile -t pillarnext .
    ```

3. **Run the Docker container:**

    To run the Docker container, utilize the provided run script with the following parameters:

    ```bash
    ./run.sh pillarnext --rm --nvidia --shm-size 8G
    ```

    - `<image-name>`: The name you assigned to the Docker image during the build process.
    - `--rm`: Automatically remove the container when it exits.
    - `--nvidia`: Run the container with NVIDIA GPU support.
    - `--shm-size`: Set the shared memory size. A larger shared memory size is required for some models.

    After running the container, a `shared-folder` directory will be created in the root of the repository. This directory is shared between the host and the container. You can use it to transfer files between the host and the container. It is useful for saving the datasets and models you want to use in the container, as well as saving the results you want to keep.


4. **Inside the container, install the dependencies:**

    ``` bash
    ./docker/install_dependencies.sh
    ```
    The dependencies need to be installed after the image is built because of cuda compatibility issues. We provide a script that installs the dependencies for you.

5. **Usage:**

For usage instructions, refer to the [Data](DATA.md) and [Run](RUN.md) sections.