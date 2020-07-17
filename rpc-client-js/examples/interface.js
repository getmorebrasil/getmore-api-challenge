const too = require('./too')

/* 
    The signature of commented functions above of the 
    functions not is mandatory, but recommended,
    because is mostly easy to understand
    what behavior of function.
*/

module.exports = () => ({
    /* foo({ notMarried, name, age }): Promise<number> */
    foo({ notMarried, name, age }) {
        return Promise.resolve({ response: { name, notMarried, age } });
    },
    /* bar(number): Promise<number> */
    bar({ string }) {
        return Promise.resolve({ response: string.toUpperCase() });
    },
    boo({ number }) {
        return Promise.resolve({ response: number * 2 });
    },
    too
})
