@echo off
echo 🛠️ Building Flutter Web...
flutter build web

echo 📂 Copie des fichiers vers le dossier gh-pages...
xcopy /E /I /Y build\web\* gh-pages\

cd gh-pages
echo ✅ Ajout des fichiers...
git add .

echo 📝 Commit...
git commit -m "Déploiement automatique Flutter Web"

echo 🚀 Push...
git push origin gh-pages
cd ..

echo 🌐 Déploiement terminé ! Rendez-vous sur :
echo https://ksontinoos2.github.io/app_habilux/
pause
