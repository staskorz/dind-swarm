#!/bin/bash

MANAGER1=dindswarm_manager1_1
MANAGER2=dindswarm_manager2_1
MANAGER3=dindswarm_manager3_1
WORKER1=dindswarm_worker1_1
WORKER2=dindswarm_worker2_1
WORKER3=dindswarm_worker3_1

echo "Initializing docker swarm on manager 1..."
docker exec ${MANAGER1} docker swarm init

echo "Getting swarm join tokens (manager and worker)..."
JOIN_MANAGER_TOKEN=$(docker exec ${MANAGER1} docker swarm join-token manager --quiet)
JOIN_WORKER_TOKEN=$(docker exec ${MANAGER1} docker swarm join-token worker --quiet)

echo "Joining manager 2..."
docker exec ${MANAGER2} docker swarm join --token ${JOIN_MANAGER_TOKEN} ${MANAGER1}
echo "Joining manager 3..."
docker exec ${MANAGER3} docker swarm join --token ${JOIN_MANAGER_TOKEN} ${MANAGER1}

echo "Joining worker 1..."
docker exec ${WORKER1} docker swarm join --token ${JOIN_WORKER_TOKEN} ${MANAGER1}
echo "Joining worker 2..."
docker exec ${WORKER2} docker swarm join --token ${JOIN_WORKER_TOKEN} ${MANAGER1}
echo "Joining worker 3..."
docker exec ${WORKER3} docker swarm join --token ${JOIN_WORKER_TOKEN} ${MANAGER1}

echo "Preventing manager 1 from running containers..."
docker exec ${MANAGER1} docker node update --availability drain manager1
echo "Preventing manager 2 from running containers..."
docker exec ${MANAGER1} docker node update --availability drain manager2
echo "Preventing manager 3 from running containers..."
docker exec ${MANAGER1} docker node update --availability drain manager3

echo "Done."
