const contract = new web3.eth.Contract(contractAbi, contractAddress);

contract.events.MessageSubmitted({}, async (error, event) => {
    if (error) {
        console.error("Error in event listener:", error);
        return;
    }

    const { user, message } = event.returnValues;

    // Store the message in your database
    await storeMessageInDatabase(user, message);
    console.log("Message stored in the database:", message);
});

async function storeMessageInDatabase(user, message) {
    // Use your preferred database library to insert the message into the database
    // For example, if you're using SQL:
    await db.query('INSERT INTO messages (user, message) VALUES (?, ?)', [user, message]);

    // Or if you're using a NoSQL database:
    await MessageModel.create({ user, message });
}
