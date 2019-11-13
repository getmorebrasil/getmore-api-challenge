/* 
    Ways to export a function for add in interfaceRpc
*/

/*
module.exports = function () {
    return 'too too'
}
*/

/*
module.exports = () => {
    return 'too too'
}
*/

const too = () => {
    return Promise.reject('problem');
}

module.exports = too
