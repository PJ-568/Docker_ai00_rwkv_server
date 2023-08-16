FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install htop git curl wget zip unzip gnupg2 -y
RUN wget https://github.com/cgisky1980/ai00_rwkv_server/releases/download/v0.1.11/ai00_server-v0.1.11-x86_64-unknown-linux-gnu.zip
RUN unzip ai00_server-v0.1.11-x86_64-unknown-linux-gnu.zip -d /root/ai00_server
RUN chmod 755 /root/ai00_server/dist/ai00_server
RUN mkdir /root/ai00_server/dist/assets/models/
RUN cd /root/ai00_server/dist/assets/models/
RUN wget https://huggingface.co/cgisky/RWKV-safetensors-fp16/resolve/main/RWKV-4-World-CHNtuned-0.4B-v1-20230618-ctx4096.st
RUN echo 'cd /root/ai00_server/dist/' >>/start.sh
RUN echo './ai00_rwkv_server --model assets/models/RWKV-4-World-CHNtuned-0.4B-v1-20230618-ctx4096.st' >>/start.sh
RUN chmod 755 /start.sh
EXPOSE 80
CMD  /start.sh
