# ChainPost 🔗📱

**AI Summit Hackathon 2025 Project**

ChainPost is a decentralized application (dApp) that captures, stores, and verifies social media content using blockchain technology to ensure integrity, permanence, and transparency. By leveraging the Internet Computer Protocol (ICP), ChainPost provides a scalable, censorship-resistant platform to preserve potentially controversial or historically significant posts, enabling users to verify authenticity and provenance collaboratively.

## 🎯 Project Overview

Built entirely from scratch during the AI Summit Hackathon 2025, ChainPost addresses the growing need for content verification and preservation in the digital age. The platform combines blockchain immutability with AI-powered sentiment analysis to create a trusted repository of social media content.

## ✨ Key Features

- **Content Verification**: External verification using tweet API data collection
- **AI-Powered Analysis**: Sentiment analysis and content formatting using AI agents
- **Blockchain Storage**: Immutable storage on Internet Computer Protocol
- **Censorship Resistance**: Decentralized architecture ensures content permanence
- **Provenance Tracking**: Complete audit trail for content authenticity

## 🏗️ Architecture

### Components
- **Frontend**: React-based web interface for content submission and verification
- **ICP Backend**: Motoko canisters for blockchain storage and data processing
- **AI Analyzer**: LLM-powered sentiment analysis and content formatting
- **Mock Twitter API**: Custom implementation to simulate Twitter API calls

### Tech Stack
- **Blockchain**: Internet Computer Protocol (ICP)
- **Backend**: Motoko
- **Frontend**: React + Vite
- **AI**: LLM Canister with Ollama integration
- **Mock API**: Custom Twitter API simulation

## 🏆 Achievements

**First Place Winner** at [DoraHacks AI Agent Summit for ICP](https://dorahacks.io/hackathon/ais/buidl)

**Project**: [https://dorahacks.io/buidl/26945](https://dorahacks.io/buidl/26945)

**Full Project**: [https://github.com/CarloCattano/Thruther](https://github.com/CarloCattano/Thruther)

## 🚀 Quick Start

### Prerequisites
- Node.js (v18+)
- DFX (Internet Computer SDK)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Thruther
   ```

2. **Start ICP local network**
   ```bash
   dfx start --background
   ```

3. **Deploy the application**
   ```bash
   dfx deploy
   ```

4. **Access the application**
   - Frontend: http://localhost:4943
   - Mock Twitter: Available via Cloudflared tunnel

## 🧪 Testing

Since Twitter API access was not available during the hackathon timeframe, this POC uses a custom mock Twitter implementation:

- **Mock Twitter Site**: Hosted locally to simulate Twitter API responses
- **Test Posts**: Use the provided mock Twitter interface to create test content
- **Verification Flow**: Submit post IDs from the mock Twitter to test the verification pipeline

### Testing Workflow
1. Create posts on the mock Twitter site
2. Submit post IDs through the ChainPost frontend
3. Verify AI analysis and blockchain storage
4. Check sentiment analysis results

## 📁 Project Structure

```
Thruther/
├── ICP_backend/          # Main ICP application
│   ├── backend/         # Motoko canisters
│   ├── frontend/        # React web interface
│   └── dfx.json         # ICP configuration
├── faketwitter/         # Mock Twitter API
└── README.md           # This file
```

## 🔧 Development

### Current TODO Items

**Frontend:**
- Reset post ID field on submit
- Send tweet info to agent/another canister
- Improve display and append incoming content

**ICP Backend:**
- Filter and organize required fields
- Send data to agent canister for AI processing

### Development Commands
```bash
# Start development environment
dfx start --background

# Deploy changes
dfx deploy

# Build frontend
cd ICP_backend/frontend && npm run build
```

## 🤝 Contributing

This project was developed during the AI Summit Hackathon 2025. For questions or contributions, please refer to the hackathon guidelines.

## 📄 License

This project is part of the AI Summit Hackathon 2025 submission.

---

**Built with ❤️ for the AI Summit Hackathon 2025**
