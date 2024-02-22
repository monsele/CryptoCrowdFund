"use client";

import type { NextPage } from "next";

const Home: NextPage = () => {
  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <h1 className="text-center">
            <span className="block text-2xl mb-2">Welcome to</span>
            <span className="block text-4xl font-bold">Crowd Fund Eth</span>
          </h1>
          <p className="text-center text-lg">This is a crowd fund application in solidity where users can</p>
          <p className="text-center text-lg">
            Interact with the solidity smart contracts by clicking on{" "}
            <code className="italic bg-base-300 text-base font-bold max-w-full break-words break-all inline-block">
              Campaign <br />
            </code>{" "}
            on the top left corner
          </p>
          <p>
            <code>lastId</code> value is used to track the last given Id for a campaign
          </p>
          <p>
            <code>CreateCampaign</code> This method creates a new campaign and assigns it a new Id
          </p>
          <p>
            <code>fundCampaign</code> This method is a payable function that allows you fund a campaign
          </p>
          <p>
            <code>PayCampaign</code> This method pushes funds to the campaign deposit address that were deposited for
            that campaign
          </p>
        </div>
      </div>
    </>
  );
};

export default Home;
