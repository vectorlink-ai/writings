# Scaling Vector Databases

For modern AI applications vector database are often dealing with text embedding vectors. For most applications these will be at the very least 512 dimensions, but more often are 1024, 1536 or greater. In addition, for some use cases data volumns will exceed 20 million records.

This sets the stage for our problem: Data volumes exceeding 20 million records start to yield significant headaches and complexities.

Let's assume 1024 dimensional vectors of 32-bit floats. This is about 4k per vector. For 10 million vectors this is about 40 Gigabytes. While memory sizes are always increasing for GPUs, 40 Gigabytes is a respectable amount. Going much larger than this is expensive.

For CPUs we can find larger memory scales. But here we find another pressing problem. The number of CPUs doesn't scale up fast enough to actually build indexes over much larger databases than those that use 10-20 million vectors.

So for GPUs we are memory constrained, and for CPUs we are processor constrained to somewhere in the ballpark of 10 million vectors. Add to this the problem that we may need to have more than one vector per data record, and we've got ourselves into some difficulty.

Essentially we have to rewarm the age old database technique for scaling: [sharding](<https://en.wikipedia.org/wiki/Shard_(database_architecture)>).

## Random Sharding

The most common technique for sharding vector databases uses _random shards_. This breaks-off random portions of the data-set and indexes each of these shards independently. The technique is widely applied, and many vector databases make use of random sharding for scaling up. This choice is often a good one due to the simplicity of the approach, the relative ease in balancing shard size, and the fact that it will scale reasonably well.

However, it is not without down-sides. Random sharding removes one of the most interesting features that graph-based approximate nearest neighbour (ANN) indexes, which include the popular [HNSW](https://arxiv.org/abs/1603.09320) and [CAGRA](https://arxiv.org/abs/2308.15136), are able to give to us. Namely, the ability to very quickly look at approximate-nearest neighbours. Approximate-nearest-neighbour search over indexed vectors is extremely fast in an ANN graph. By contrast there is a significant overhead in searching one of these ANNs.

This means that ANN approaches to clustering are going to be fundamentally difficult with a random sharding approach.

Supposing we want to find all vectors near a given vector in the database and we have $N$ vectors and $M$ shards. With random sharding we now have to search ever shard for this vector. We have to employ $M$ machines to search for this vector, and we can expect the cost of the search to be like $O(\ln(N))$.

Now if we try to find the cluster surrounding every vector, we have to run $N$ searches on $M$ machines with a search of cost which goes something like $O(N   \ln(N))$.

Imagine that N is 1 billion and M is 100. We have to search something on the order of 9 billion times a search cost on a 100 machines. Certainly not impossible, but costly and slow!

## Spatial Sharding

Luckily, there is another approach to sharding which we can take: _spatial sharding_. Essentially this technique attempts to partition the space by using a small index. These partitions are then used to create the individual shards. In some ways it is similar to [product quantization](https://en.wikipedia.org/wiki/Vector_quantization) which attempts to reduce information content by reducing the search space into buckets. But here we are bucking vectors into a shard based on how close they are to some selection.

This approach is unfortunately a bit more complicated. Somehow we have to decide how to partition the space, and how to balance the partitions. But as we'll see at the end, there is a big potential pay-off. Let's see what such a scheme would look like.

First, we will create a small random sample from our complete dataset. We then index this sample. We are going to use this index to partition our results.

We will search for the nearest vector in the final layer of our index.
