## IDEA 

_ the project is entirely new and built from scratch during the event. AI SUMMIT HACKATHON 2025_

ChainPost is a decentralized application (dApp) that captures, stores, and verifies social media content using blockchain technology to ensure integrity, permanence, and transparency. By leveraging the Internet Computer Protocol (ICP), ChainPost provides a scalable, censorship-resistant platform to preserve potentially controversial or historically significant posts, enabling users to verify authenticity and provenance collaboratively.

We made our own mockup twitter to emulate twitter API calls as close as possible with the real one.
In this way, the tweets that users submit get an external verification using the tweet API and the data is collected and an AI agent formats it and extracts the sentiment parameters out of it.


## Testing
Since there is short time for the hackathon and twitter API was not an option, this POC should be run with posts hosted at our fake-twitter site 


## TODO:
  - Make it platform agnostic in the future with multiple conectors to other platforms
  - Add a map of posts to store them in chain.
  - Browser extension UX
  - Explore clustering stored mappings by similarity/affinity of sentiment


## Runing locally 
To run locally follow the docs using dfx start and deploy