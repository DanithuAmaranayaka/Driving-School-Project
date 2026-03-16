const fs = require('fs');
const path = require('path');

const dir = 'src/main/webapp';
const files = fs.readdirSync(dir);

for (const file of files) {
    if (file.endsWith('.jsp')) {
        const filePath = path.join(dir, file);
        let content = fs.readFileSync(filePath, 'utf8');
        let newContent = content.replace(/http:\/\/java\.sun\.com\/jsp\/jstl\/core/g, 'jakarta.tags.core');
        
        if (content !== newContent) {
            // Write to a temporary file first then rename to avoid descriptor locking
            const tmpPath = filePath + '.tmp';
            fs.writeFileSync(tmpPath, newContent, 'utf8');
            fs.renameSync(tmpPath, filePath);
            console.log('Fixed: ' + filePath);
        }
    }
}
console.log('Done!');
