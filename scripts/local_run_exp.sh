#!/bin/sh
set -e

NAME=exp_`date "+%m_%d_%H_%M_%S"`
EXP_FILE=configurations/humanoid.json
tmux new -s $NAME -d
tmux send-keys -t $NAME '. scripts/local_env_setup.sh' C-m
tmux send-keys -t $NAME 'python3 -m es_distributed.main master --master_socket_path run/redis_master_tmp/es_redis_master.sock --exp_file '"$EXP_FILE"" --log_dir run/master_log" C-m
tmux split-window -t $NAME
tmux send-keys -t $NAME '. scripts/local_env_setup.sh' C-m
tmux send-keys -t $NAME 'python3 -m es_distributed.main workers --master_host es-redis-master --relay_socket_path run/redis_slave_tmp/es_redis_relay.sock --num_workers 12' C-m
tmux a -t $NAME