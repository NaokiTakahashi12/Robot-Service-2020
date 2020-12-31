
FROM naokitakahashi12/ignition:citadel-bionic

RUN apt update --quiet \
    && apt upgrade --quiet -y \
    && apt install --quiet --no-install-recommends -y \
        curl \
        git \
        g++-8 \
        gfortran \
        gnupg2 \
        cmake make \
        liblapack-dev \
        libeigen3-dev \
        libmetis-dev \
    && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list' \
    && curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add - \
    && apt update --quiet \
    && apt install --quiet --no-install-recommends -y \
        ros-melodic-ros-base \
    && apt --purge remove -y \
        gnupg2 \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/build \
    && cd /tmp/build \
    && export CC=gcc-8 \
    && export CXX=g++-8 \
    && git clone https://github.com/coin-or-tools/ThirdParty-Mumps.git --depth=1 \
    && cd ThirdParty-Mumps/ \
    && ./get.Mumps \
    && ./configure \
    && make install \
    && cd .. \
    && git clone https://github.com/coin-or/Ipopt.git --depth=1 \
    && cd Ipopt \
    && ./configure \
    && make install \
    && mv /usr/local/include/coin-or /usr/local/include/coin \
    && cd ../ \
    && git clone https://github.com/coin-or/CppAD.git --depth=1 \
    && mkdir CppAD/build \
    && cd CppAD/build \
    && cmake .. \
    && make install \
    && cd / \
    && rm -rf /tmp/build

COPY preinstall.repos.yaml /tmp/.

RUN apt update --quiet \
    && apt install --quiet --no-install-recommends -y \
        python-rosdep \
        apt-utils \
        python3-vcstool \
    && rosdep init \
    && rosdep update \
    && mkdir -p /preinstall/src \
    && cd /preinstall \
    && vcs import src < /tmp/preinstall.repos.yaml \
    && /opt/ros/melodic/env.sh rosdep install \
        --rosdistro melodic \
        --from-paths src \
        --ignore-src \
        -r -y \
    && CC=gcc-8 CXX=g++-8 /opt/ros/melodic/env.sh \
        /opt/ros/melodic/bin/catkin_make \
            -j 1 \
            -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    && apt --purge remove -y \
        python-rosdep \
        apt-utils \
        python3-vcstool \
    && rm -rf build \
    && cd / \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN apt update --quiet \
    && apt install --quiet --no-install-recommends -y \
        ros-melodic-velodyne \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN echo "source /ign_ws/install/setup.bash" >> ~/.bashrc \
    && echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc \
    && echo "source /preinstall/devel/setup.bash" >> ~/.bashrc

COPY ros_entrypoint.bash /.
ENTRYPOINT ["/ros_entrypoint.bash"]

CMD ["/bin/bash"]

