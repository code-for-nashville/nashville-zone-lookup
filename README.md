# Parcel

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
- Install the frontend dependencies `cd frontend && npm install`.
- Run the frontend's HTTP server `cd frontend && npm run dev`.

_Note: Additional commands are available for the frontend app and are documented in its [README](frontend)._

To build and run this app for production:
- Install the Mix dependencies `mix deps.get`.
- Compile the project `mix compile`.
- Build and copy the frontend app to the Phoenix server `mix parcel.prepare_static_assets`.
- Run the Phoenix server `mix phx.server`.

## Planning
- For a detailed description of the project, check out the [Request for Volunteers](https://docs.google.com/document/d/17DNk0QQyi8SEK4utcMt3zT-Dc6vXzA_zcFwrEENvKJo/edit?usp=sharing).
- For other shared documents, check out [Google Drive](https://drive.google.com/drive/folders/0Byi0NApRjhBXekRiVFA5MlZ2OTQ?usp=sharing).
- For the planning board, check out [Github](https://github.com/code-for-nashville/parcel/projects/1).

Email nick@codefornashville.org if the above links do not work.

## License
MIT
