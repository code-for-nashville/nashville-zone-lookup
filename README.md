# Parcel [![Build Status](https://travis-ci.org/code-for-nashville/parcel.svg?branch=temp%2Fsetup-travis)](https://travis-ci.org/code-for-nashville/parcel)

Answering your Nashville, TN acceptable land use questions.

## Structure
Parcel is composed of two separate parts:
- A VueJS frontend
- Elixir/Phoenix backend

This backend serves both the frontend and the data consumed by the frontend.

## Running
Prerequisites
- Make sure Elixir and NodeJS are installed.

To build and run this app locally:
- Install the Mix dependencies `mix deps.get`.
- Compile the project `mix compile`.
- Run the Phoenix server `mix phx.server`.
- Navigate to frontend app `cd frontend`.
- Install the NPM dependencies `npm install`.
- Run the frontend's HTTP server `npm run dev`.

_Note: Additional commands are available for the frontend app and are documented in its [README](frontend)._

To build and run this app for production:
- Install the Mix dependencies `mix deps.get`.
- Compile the project `mix compile`.
- Build and copy the frontend app to the Phoenix server `mix parcel.prepare_static_assets`.
- Run the Phoenix server `mix phx.server`.

## Testing
To test the backend:
- Install the Mix dependencies `mix deps.get`.
- Compile the project `mix compile`.
- Run tests `mix test`.

To test the frontend:
- Navigate to frontend app `cd frontend`.
- Install the NPM dependencies `npm install`.
- Run the unit tests `npm run unit`.
- Run the end-to-end tests `npm run e2e`.
- Run the unit and end-to-end tests `npm run test`.

## Planning
- For a detailed description of the project, check out the [Request for Volunteers](https://docs.google.com/document/d/17DNk0QQyi8SEK4utcMt3zT-Dc6vXzA_zcFwrEENvKJo/edit?usp=sharing).
- For other shared documents, check out [Google Drive](https://drive.google.com/drive/folders/0Byi0NApRjhBXekRiVFA5MlZ2OTQ?usp=sharing).
- For the latest design documents, check out [Invision](https://projects.invisionapp.com/share/8WCW9Z0QD#/screens/247107120_Starting_Page).
- For the planning board, check out [Github](https://github.com/code-for-nashville/parcel/projects/1).
- [Latest list of zoning codes](https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.08ZODILAUS)

Email nick@codefornashville.org if the above links do not work.

## License
MIT
