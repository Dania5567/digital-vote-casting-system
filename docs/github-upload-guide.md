# Publish on GitHub

## Web upload

1. Unzip the downloadable project package.
2. Go to https://github.com/new.
3. Name the repository **digital-vote-casting-system**.
4. Select **Public** (for a portfolio) and create an empty repository.
5. Select **Add file → Upload files** and drag in the **contents** of the extracted folder, preserving the folder paths.
6. Commit the changes. GitHub automatically shows `README.md` on the repository homepage.

## Git command line

```bash
cd vote-casting-system
git init
git add .
git commit -m "Add digital vote casting system project"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/digital-vote-casting-system.git
git push -u origin main
```

Create the matching empty repository on GitHub before pushing. Replace `YOUR-USERNAME` with your actual GitHub username.

## Suggested GitHub description

Digital vote casting system developed using digital logic design, Proteus simulation, and a breadboard prototype with seven-segment displays. Includes a Verilog reference model and automated tests.

## Suggested repository topics

`digital-logic` `proteus` `voting-system` `electronic-circuits` `breadboard` `seven-segment-display` `verilog` `logic-design` `student-project`
