# Example Hashtags app

To create the basic directory structure and miners use the following commands

Create the app:  
<tt>mines new hashtags</tt>

Create the twitter miner:  
<tt>mines generate twitter publicstream</tt>

Create the process miner:  
<tt>mines generate process process</tt>

Create the metrics miner:  
<tt>mines generate metrics metrics</tt>

Resolve project's dependencies with bundler:  
<tt>bundle install</tt>

Each miner is independent from the others,
they use Message Queues to communicate and a [TimeSeries metrics store](https://github.com/panayiotis/time_series)
to share data.
