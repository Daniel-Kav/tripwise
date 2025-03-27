# TripWise - CMV Trip Planning & ELD Logging System

TripWise is a comprehensive web application designed to assist commercial motor vehicle (CMV) drivers in planning trips and generating Electronic Logging Device (ELD) logs while adhering to FMCSA Hours of Service (HOS) regulations.

## Features

- Interactive route planning with map visualization
- Automated ELD log generation
- HOS compliance monitoring
- Rest area and fueling station recommendations
- Real-time HOS violation alerts
- Support for 70-hour/8-day cycle
- Sleeper berth provisions
- Personal conveyance rules

## Tech Stack

- Backend: Django 4.2
- Frontend: React 18 with TypeScript
- Database: PostgreSQL
- Maps: OpenStreetMap with Leaflet
- Authentication: JWT
- Deployment: Vercel (Frontend) & Railway (Backend)

## Prerequisites

- Python 3.11+
- Node.js 18+
- PostgreSQL 14+
- npm or yarn

## Setup Instructions

### Backend Setup

1. Create and activate a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
cd backend
pip install -r requirements.txt
```

3. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Run migrations:
```bash
python manage.py migrate
```

5. Start the development server:
```bash
python manage.py runserver
```

### Frontend Setup

1. Install dependencies:
```bash
cd frontend
npm install
```

2. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

3. Start the development server:
```bash
npm run dev
```

## Project Structure

```
tripwise/
├── backend/                 # Django backend
│   ├── api/                # API endpoints
│   ├── core/               # Core functionality
│   ├── trips/              # Trip management
│   └── eld/                # ELD logging
├── frontend/               # React frontend
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── pages/         # Page components
│   │   ├── services/      # API services
│   │   └── utils/         # Utility functions
│   └── public/            # Static files
└── docs/                  # Documentation
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- FMCSA for HOS regulations
- OpenStreetMap for map data
- All contributors and maintainers 