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
- Make sure Docker is installed

To build and run this app locally:
- Install the Mix dependencies `mix deps.get`.
- Compile the project `mix compile`.
- Run the Phoenix server `mix phx.server`.
- Navigate to frontend app `cd frontend`.
- Install the NPM dependencies `npm install`.
- Run the frontend's HTTP server `npm run dev`.
- Run the database in the background with `docker run -p 5432:5432 --name parcel_db -d postgres:9.6`.
- Create, seed, and migrate your database with `mix ecto.setup && mix ecto.migrate`
- Optionally run the [Postgres shell](https://www.postgresql.org/docs/current/static/app-psql.html) with `docker exec -it parcel_db psql -U postgres parcel_dev`


_Note: Additional commands are available for the frontend app and are documented in its [README](frontend)._

To build and run this app for production:
- Install the Mix dependencies `mix deps.get`.
- Compile the project `mix compile`.
- Build and copy the frontend app to the Phoenix server `mix parcel.prepare_static_assets`.
- Run the Phoenix server `mix phx.server`.

## Testing
To unit test the backend:
- Install the Mix dependencies `mix deps.get`.
- Compile the project `mix compile`.
- Run tests `mix test`.
- Run tests against external systems `mix test --include external`.

To test the frontend:
- Navigate to frontend app `cd frontend`.
- Install the NPM dependencies `npm install`.
- Run the unit tests `npm run unit`.
- Run the end-to-end tests `npm run e2e`.
- Run the unit and end-to-end tests `npm run test`.

## Importing Data
* Make sure you've followed the database setup instructions in [Running](#running). _Note: `mix ecto.setup` inserts seed data require for the data ingestion to run`_
* Download the latest zoning spreadsheet [here](https://docs.google.com/spreadsheets/d/1O0Qc8nErSbstCiWpbpRQ0tPMS0NukCmcov2-s_u8Umg)
* Run `mix help parcel.ingest_land_use_table` and follow instructions to execute that command.
* If you need to re-import data, drop and re-create your database:
`mix ecto.drop && mix ecto.setup && mix ecto.migrate`

## Planning
- For a detailed description of the project, check out the [Request for Volunteers](https://docs.google.com/document/d/17DNk0QQyi8SEK4utcMt3zT-Dc6vXzA_zcFwrEENvKJo/edit?usp=sharing).
- For other shared documents, check out [Google Drive](https://drive.google.com/drive/folders/0Byi0NApRjhBXekRiVFA5MlZ2OTQ?usp=sharing).
- For the latest design documents, check out [Invision](https://projects.invisionapp.com/freehand/document/K7B47ZJqI).
- For the planning board, check out [Github](https://github.com/code-for-nashville/parcel/projects/1).
- [Latest list of zoning codes](https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.08ZODILAUS)

Email nick@codefornashville.org if the above links do not work.

## License
MIT
