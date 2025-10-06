'use strict';
import * as fs from 'node:fs';



let dependencies = process.env.AZ_DEPENDENCIES;
let devDependencies = process.env.AZ_DEV_DEPENDENCIES;


changeDependecies("dependencies", dependencies, (result) => {
    if (result && result.success) {
        changeDependecies("devDependencies", devDependencies, (result2) => {
            if (result2 && result2.success) {

            }
        });
    }
});


function changeDependecies(type, value, callback) {
    if (value && value !== '') {
        fs.readFile('./package.json', (err, data) => {
            if (err) {
                callback({ success: false });
                throw err;
            };
            let packageJSON = JSON.parse(data);
            console.log('[Azentio] >>> Changing ' + type + ' in package.json to: ' + value);

            try {
                const jsonValue = JSON.parse(value);
                Object.keys(jsonValue).forEach((key) => {
                    packageJSON[type][key] = jsonValue[key];
                });
            } catch (error) {
                console.log('[Azentio] >>> Error while updating the package.json ');
                throw error;
            }


            let newData = JSON.stringify(packageJSON);
            console.log('[Azentio] >>> Changing package.json to ' + newData);
            fs.writeFileSync('./package.json', newData, (err2) => {
                if (err2) {
                    callback({ success: false });
                    throw err2;
                };
                console.log('[Azentio] >>> Successfully updated package.json value with ' + newData);
                callback({ success: true });
            });
            // packageJSON[type] = { ...packageJSON[type], ...value };
        });
    } else {
        console.log('[Azentio] >>> Nothing to change in ' + type + ' in package.json ');
        callback({ success: true });
    }
}