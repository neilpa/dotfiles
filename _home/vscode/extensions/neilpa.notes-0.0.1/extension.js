// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const { doesNotThrow } = require('assert');
const vscode = require('vscode'),
  fs = require('fs'),
  path = require('path');

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed

/**
 * @param {vscode.ExtensionContext} context
 */
function activate(context) {

	// The command has been defined in the package.json file
	// Now provide the implementation of the command with  registerCommand
	// The commandId parameter must match the command field in package.json
	let disposable = vscode.commands.registerCommand('notes.openToday', async () => {

    // Create the new file if needed
    const root = "/Users/neilpa/notes";
    const today = new Date();
    const yyyy = today.getFullYear(), mm = today.getMonth(), dd = today.getDate();
    const weekday = days[today.getDay()], dow = weekday.slice(0, 3);
    const mon = months[mm];
    const MM = pad(mm+1), DD = pad(dd);

    const filename = `${yyyy}-${MM}-${DD}.md`;
    const directory = path.join(root, 'journal', `${yyyy}`, `${MM}.${mon}`, `${DD}.${dow}`);
    const filepath = path.join(directory, filename);
    if (!fs.existsSync(filepath)) {
      fs.mkdirSync(directory, { recursive: true });
      const header = `## ${yyyy}-${mon}-${DD}.${weekday}\n`
      fs.writeFileSync(filepath, header, 'utf8'); // TODO: Async promise?
    }

    // TODO: Can't switch to another workspace and open target file?
    // if (root !== vscode.workspace.rootPath) {
    //   const notesUri = vscode.Uri.file(root);
    //   await vscode.commands.executeCommand('vscode.openFolder', notesUri, true);
    // }

    const uri = vscode.Uri.file(filepath);
    const doc = await vscode.workspace.openTextDocument(uri);
    const editor = await vscode.window.showTextDocument(doc);

    // TODO: Scroll to end of file?
	});

	context.subscriptions.push(disposable);
}

// this method is called when your extension is deactivated
function deactivate() {}

const days = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
const months = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"];

function pad(n) { return String(n).padStart(2, '0'); }

// eslint-disable-next-line no-undef
module.exports = {
	activate,
	deactivate
}
