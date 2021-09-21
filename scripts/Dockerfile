FROM openai-es

WORKDIR /root
COPY dependency.sh ./
COPY mujoco ./mujoco
RUN chmod +x ./dependency.sh && ./dependency.sh && rm dependency.sh \
    && rm -rf mujoco
