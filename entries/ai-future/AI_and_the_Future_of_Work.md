# How to survive the AI revolution in Data Management

At [VectorLink.ai](https://vectorlink.ai) we have been performing experiments with LLMs with the aim of automating or improving various data management processes. Specifically we've had a lot of success with improving outcomes for difficult record matching problems (see: [LLMs and machine learning for record matching](https://vectorlink.ai/blog/leveraging-llms-and-machine-learning-for-record-matching/), [LLM Classifier Bootstrapping](https://vectorlink.ai/blog/llm-classifier-bootstrapping/), [Entity Resolution across human languages](https://vectorlink.ai/blog/ai-entity-resolution-bridging-records/)).

The use of vector embeddings and the language capabilities of LLMs have opened up a huge range of new potential applications, many of which would have been complete science fiction only 10 years ago.

This is going to have profound impacts and not only in data management, but also in the nature of IT employment, and society more generally. Profound change is profoundly disruptive, and since luck favours the prepared, we would do well to have a bit of a think about the kinds of changes that will happen. There will be big opportunities, but also grave dangers for companies that do not adapt.

## What is different this time?

So what are these changes and how can businesses be prepared for the disruption? Automation has always been based on essentially the same principle. If you can reduce human time spent on production by employing machinery which is cheaper than that human time, then you have an effective automation. This process has been playing out for over a hundred years and it is the driving motor of growth. It is also the reason that some companies (and even states) win, and others lose. If you can produce something more cheaply, then you make bigger profits and/or you win market share.

In many cases, automation will be time saving, causing a reorientation of current jobs and increasing productivity. But some jobs are already vanishing as a result of AI. In the translation industry we are already seeing a profound impact. AI is so good at translation that translation has largely been reduced to the task of post-editing, something which was already present! The translators themselves are not really needed.

In our own [experiments](https://vectorlink.ai/blog/llm-classifier-bootstrapping/) we have found that generative AI can be very effective at generating training sets by annotation, much in the way that a human would do. In this experiment I wasn't able to do better than the AI unless I used auxiliary information from the internet (something which will be possible to add to the AI's arsenal!). The machine is ready to replace me in this thankless task (thank goodness!).

And the price? It was approximately $\$$2 per hour. It will be hard to find a human who can do it at that price point. This is a major challenge to services like Mechanical Turk (ironically named for a famous [fake automation](https://en.wikipedia.org/wiki/Mechanical_Turk) which can now be automated). And the price point has been falling very quickly. Just over the last year we saw the price of embeddings fall by a factor of 10 (literally!).

The change will likely not be everywhere, all at once. A recent MIT study which shows that [Automation can be expensive](https://www.csail.mit.edu/news/rethinking-ais-impact-mit-csail-study-reveals-economic-limits-job-automation) and because of this, the process of automation will be more gradual than some more enthusiastic proponents of AI assume. However if price points are falling as fast as they appear to be, then what is too expensive today may be extremely cheap next year. $\$$50 and hour could quickly fall to $\$$5. It seems to me that the optimists are likely to be more right and the good money is on betting on automation now rather than later when your competitor already has the process in place.

In their 2011 work [Race Against the Machine](https://en.wikipedia.org/wiki/Race_Against_the_Machine) Erik Brynjolfsson, Andrew McAfee predicted big changes in the economy as a result of automation. This was just at the point that generative AI was beginning to make big forward strides, and so is now looking to be very prescient.

## AI automation is a "need to have", not a "nice to have"

The new automation threatens to be different than in the past because it is no longer just about making manual labour more efficient or increasing the productivity of cognitive labour as it was in the past. It is now, already, replacing cognitive labour in earnest. It may not _yet_ be the most intelligent employee you could hire, and it is not so great at programming or mathematics at the moment, but it is getting better and fast. The space of potential automation will span the entire gamut of human jobs.

For companies this means success will require a serious automation strategy. A study produced by the now Nobel Prize winning economics researcher Daron Acemoglu showed that [firms which adopt robots win](https://news.mit.edu/2020/robots-help-firms-workers-struggle-0505). Overall the total labour displacement in manufacturing was three humans for every one robot adopted. But those companies which employed robots grew their workforce and market share and their competitors were essentially crushed.

Now that robots can do cognitive labour the same process will play out in all sorts of data management tasks. Those that can identify cognitive automation potential and are fastest at adopting them will win and grow, and those who do not will be made quickly non-viable.

## What do I need to be automating now?

To remain competitive we should start with those things most in need of AI for automation which can be attacked with current technology:

- Tagging and taxonomy
- Entity resolution
- Data transformation
- Search and Reporting

These core data management tasks are all likely to see heavy automation which will require a big AI component. Discoverability engineering will be a task undertaken by AIs which produce high quality indexes which employ extremely easy to use natural language interfaces. The identification of which entities (people, corporations, products) are associated with data will be identified and curated by an AI.

Not only is record matching possible, but classification of all records to the appropriate entity is possible. The process of data engineering which produces data products will still require some architecture by humans (though much can probably be cookie-cutter for an industry), but the process of filling it will not.

This, in turn, will replace a whole swath of reporting tools and dashboards which will go the way of the dodo as insights can be obtained via conversation. We will get the AI to give us the report which is needed now, rather than the one which seemed important 6 months ago when it was given to the data science team.

The long term implications of this process will unfortunately threaten increasing [inequality](https://news.mit.edu/2022/automation-drives-income-inequality-1121). But solutions to this problem require big picture approaches to the economy in general. The role of companies and the relationship to the specifics are more clear. The winners tomorrow need to be automating cognitive labour now.
