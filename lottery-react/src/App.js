
import './App.css';
import web3 from "./Web3";
import lottery from './lottery';
import React, { useState, useEffect } from 'react';
function App() {
  state = {
    manager:""
  }

  const [manager, setManager] = useState("");

  useEffect(() => {
    async function fetchManager() {
      const manager = await lottery.methods.manager().call();
      setManager(manager);
    }

    fetchManager();
    
    web3.eth.getAccounts()
      .then(console.log);
  }, []);
  return (
    <div>
      <h2>Lottery Contract</h2>
      <p>This contract is managed by {manager} </p>
    </div>
    
  );
}

export default App;
