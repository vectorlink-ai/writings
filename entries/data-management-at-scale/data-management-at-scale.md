# Externalisation: The Future of Data Management @ Scale

Just as data management has become more pervasive, so has scale become pervasive. Data management is never completely straightforward, but data management at large scales presents us with certain additional unique challenges. Luckily, practitioners have been chipping away at these problems for a while and we have a quite of tools and techniques to help.

In the area of OLAP (OnLine Analytic Processing) this has given rise to a stack of solutions for data pipelining. The Apache stack, which includes Parquet, Arrow, DataFusion among other elements, enables us to use cloud storage to manage our data resources. These objects can be queried as though they were a database, using well trodden query languages such as SQL or more fluent styles directly in code.

On top of this infrastructure are built a host of more elaborated solutions such as Dremio, and DeltaLake. These provide abstraction layers for specific aspects of data management using this stack and general approach.

These sorts of tools allow _Data Lakes_ to be utilised where _Data Warehouses_ might have been previously. Data Lakes are mixed structured and unstructured data assets, either in their initial form, whereas a Data Warehouse are structured data assets which are the result of a data pipeline (usually some sort of extract, transform, load).

The difference between the two becomes somewhat murky with the introduction of data catalogues (such as OpenMetadata, DataHub) for the Data Lakes, and even murkier with the introduction of _Data Lakehouses_ which provide additional guarantees over these assets, such as transactionality or data quality.

In all of these systems, whether to assist in ETL for Data Warehouses, or to enable derived assets in Data Lakes, we can make use of Data Orchaestration tools. Since these pipelines are often large and complex, it's helpful to have a high level _dashboard_ view of the pipelines which can centralise reporting and progress monitoring, as well as ensure reproducability and documentation of process. Popular examples of these tools include Airflow, Dagster and Prefect.

## The Monolith

The data warehouse faces a lot of fundamental problems at scale. Centralisation of data quality and data format requires large central teams and reduces agility. New data assets are hard to encorporate, data quality problems which are noticed by operational teams often take a long time to work into the ETL process, and the shape of data may not be the most useful or natural for those trying to utilise the assets. In short, the centralisation of governance has overheads in time, resources and quality.

In addition, systems which try to give the sorts of data quality and business logic guarantees have a presure to maximise control over resources. For instance, the easiest way to ensure ACID properties (Atomicity Consistency Isolation and Durability) is to have everything live in a single RDBMS (Relational Database Management System).

However, things get even worse with the modern AI enabled stack. Here we will also need documents, vectors and graphs in order to make the most use out of AI techniques. One database to rule them all.

Probably this process of accumulating everything is even feasible for big database players. However, so far, the multimodal offerings in which graph features or vector features are combined in a traditional RDBMS, or vector features combined into a graph, etc. tend to be worse than those offered by the individual specialists. This really should be unsurprising given that they are generally design afterthoughts. We may get one database to rule them all, but it is probably not a very good one.

To make matters worse, at scale we need to distribute workloads. Doing this in a single monolithic database is extremely hard. The _right_ process for creating a large scale vector pipeline that has to distribute over a hundred machines, for instance, may require a lot more flexibility in the data pipeline than a database typically exposes.

Further we may know a lot about the current data pipeline and what guarantees are required and which are not. So much effort has gone into distributed RDBMS technology alone which can help us pretend that we are simply on one computer, but sometimes its better not to pretend and then these abstractions hide important details.

# Breaking the Monolith: Externalisation

Various philosophies have developed to address this problem. Data Mesh, is one notable example, which sees a more distributed data governance approach as being desirable to improve agility and quality. The philosophy aims to put operational teams in charge of maintaining data assets in a way that is exposed to the entire organisation, removing the need for centralisation outside of global guidelines for quality data assets.

We could probably also include the previously mentioned idea of a Data Lakehouses is an attempt to give some of the benefits of centralisation to the more distributed design.

We are coining the term _externalisation_ to talk about the general process of trying to achieve the same sorts of benefits we see from centralisation in something like a RDBMS, Vector DB, or Graph DB, but with these more diffuse data lakes. This is achieved by exposing specific operations, libraries and tools which can give flexibility to the mechanism of discovery, distribution and data orchaestration and which achieves some of the guarantees or simplicity which the monolith provides.

## Gaps in Externalisation

The attractiveness of the Data Mesh philosophy is that the problems of the monolith at scale are real. But there are still gaps in being able to provide an effective distributed environment.

At VectorLink, we have tried to compile a list of aspects of the externalised approach that we have encountered which are somewhat awkward in our work. The list of course is not at all exhaustive and some of the gaps may be partially filled but with tools that we find awkward or brittle, or are completely filled but we don't know about it yet (please tell us if they are!). The list is really to give a sort of indication of how we could close the distance so that dataware houses can become less desirable. We will go into detail on each of these subsequently.

- Transactions
- Provenance
- Schema
- Graphs
- Vectors

## Transactions

If you have a straight through pipeline processing some time quanta of work that produces a report at the end, then often times you can just feed everything forward through a series of transformations and that is that.

However, it is often the case that we would like to keep a record perhaps of some entity, in which we want to perform mutations.

This leads us to a problem when more than one process wants to change more than one data resource in a way that is _consistent_. A classic example is a bank account withdraw which is deposited in another bank. If we withdraw the money, we need to be sure that the right amount of money is there, and that if we deposit it in the other account, it no longer remains in the original account for any amount of time at all (lest it be double spent).

RDMBSs are fantastic at maintaining this sort of thing by giving us ACID properties. Every operation feels logically like it is taking place in isolation, so there is no need to worry about how the various operations interact.

However, if we are to externalise this, we need an external transaction manager. And this is not completely untrod ground. Two notable examples are Seata and DTM, both opensource transaction managers used in anger by real systems.

DTM is well thought out and provides several paradigms for transactions including two-phase, try-confirm-cancel, and SAGA among others. Yet, DTM is not looking particularly healthy, the last commit was 6mo ago and it failed some CI/CD health checks.

Seata is looking more healthy with active development, but it is also in the Apache incubator stage and looks fairly rough around the edges.

Many of these transaction managers also require that local operations are already ACID. This means that there is also a need here for technologies that provide local properties.

From our survey it seems there is still room for something with a nice developer experience that can live in a cross-language environment.

## Incrementality

Incrementality is critical to many data pipelines. You may get periodic updates of information, such as current pricing information etc. which needs to be utilised in your

## Provenance

## Schema

## Graphs

The Graph Database world has quite a number of players, but Neo4j now stands as the most well known among them. Another notable example however is TigerGraph which was deigned from the off to scale up, and so is much better for extremely large projects than Neo4j.

But these examples are both monoliths. They have all of the same drawbacks that RDBMSs have, so is there a way to break the graph for parts?

Some of the challenges of graph database relate to the problem of how to shard the data, and how to perform queries after sharding. These problems could actually become easier if they are part of the data pipeline and externalised. Individual shards could potentially be processed separately if certain constraints are known to hold.

And the problem of query over graphs can't be easily settled by some automatic procedure. Graph segmentation is a hard problem, and highly connected parts of the graph living on different computational blocks is a nightmare for efficiency.

Because of this there is a lot of potential for improvement.

## Vectors
