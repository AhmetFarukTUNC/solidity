import './App.css';
import web3 from "./Web3";
import lottery from './lottery';
import React, { useState, useEffect } from 'react';
function App() {
  

  const [manager, setManager] = useState("");
  const [players, setPlayers] = useState([]);
  const [balance, setBalance] = useState("0");
  const [value, setValue] = useState(""); // State for input value

 


  useEffect(() => {
    async function fetchManager() {
      const manager = await lottery.methods.manager().call();
      setManager(manager);
      const players = await lottery.methods.getPlayers().call()
      setPlayers(players);
      const balance = await web3.eth.getBalance(lottery.options.address);
      setBalance(balance);

      


    }

    fetchManager();
    
    web3.eth.getAccounts()
      .then(console.log);
  }, []);

  const handleChange = (event) => {
    setValue(event.target.value); // Update input value state
  };

  const handleSubmit = async  (event) => {
    event.preventDefault();

    const accounts = await web3.eth.getAccounts();

    console.log(accounts)

    await lottery.methods.enter().send({
      from:accounts[0],
      value:web3.utils.toWei(value,"ether")
    })

    // Logic to handle entering the lottery with `value`
    console.log(`Entered with ${value} ether`);
    // You can add your logic here to interact with the contract
  };

  return (
    <div>
      <h2>Lottery Contract</h2>
      <p>This contract is managed by {manager} </p>
      <p>There are currently {players.length} people entered,competing to win {web3.utils.fromWei(balance,"ether")} ether!</p>
      <form onSubmit={handleSubmit}>
        <h4>Want to try your luck?</h4>
        <div>
          <label>Amount of ether to enter</label>
          <input type='text'
          value= {value}
          onChange={handleChange}

          />
        </div>
        <button>Enter</button>
      </form>
    </div>
    
  );
}

export default App;
