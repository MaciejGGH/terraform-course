console.log('Loading function');

export const handler = async (event, context) => {
    console.log('Received event:', JSON.stringify(event, null, 2));
    console.log('event.body  =', JSON.parse(event.body));
    console.log('event.body JSON.parse =', JSON.parse(event.body));
 // Parse event.body if it's a string
    const parsedBody = typeof event.body === 'string' ? JSON.parse(event.body) : event.body;    
    console.log('event.body.key1  =', parsedBody.key1);
    console.log('value1 =', parsedBody?.key1);
    console.log('value2 =', parsedBody?.key2);
    console.log('value3 =', parsedBody?.key3);
    return parsedBody.key1 ? parsedBody.key2 : 'empty payload';  // Echo back the first key value
    // throw new Error('Something went wrong');
};
