console.log('Loading function');

export const handler = async (event, context) => {
    console.log('Received event:', JSON.stringify(event, null, 2));
    // Check if the event is empty
    if (!event) {
        console.log('Event is empty');
        return 'empty payload';
    }
    let parsedBody;

    try {
        // Check if event.body exists
        if (event.body) {
            console.log('Parsing event.body');
            parsedBody = typeof event.body === 'string' ? JSON.parse(event.body) : event.body;
        } else {
            console.log('Parsing event directly as JSON');
            parsedBody = typeof event === 'string' ? JSON.parse(event) : event;
        }
    } catch (error) {
        console.error('Error parsing JSON:', error.message);
        return 'Invalid JSON payload';
    }
  
    // Log the parsed body
    console.log('Parsed body:', parsedBody);

    // Check if parsedBody is valid and contains the expected keys
    if (!parsedBody || typeof parsedBody !== 'object') {
        return 'Parsed body is not a valid object';
    }

    console.log('value1 =', parsedBody?.key1);
    console.log('value2 =', parsedBody?.key2);
    console.log('value3 =', parsedBody?.key3);
    return parsedBody.key1 ? parsedBody.key2 : 'empty parsedBody';  // Echo back the first key value
};
