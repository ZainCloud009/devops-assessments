pipeline {
    agent { label 'agentzain' } // Yahan apne Jenkins Agent ka exact label dein

    environment {
        APP_DIR = '/var/www/html/devops-assessments/app' // Agent server par project directory path
        DB_HOST = '172.31.5.23'                        // Aap ke DB Server ki IP
    }

    stages {
        stage('Checkout Code') {
            steps {
                dir("${env.APP_DIR}") {
                    echo 'Pulling latest changes from GitHub...'
                    sh 'git pull origin main'
                }
            }
        }

        stage('Build & Deploy Docker Container') {
            steps {
                dir("${env.APP_DIR}") {
                    echo 'Rebuilding Docker Image and Running Container...'
                    sh '''
                        docker build --no-cache -t my-laravel-app .
                        docker rm -f laravel_app || true
                        docker run -d --name laravel_app -e DB_HOST=${DB_HOST} -p 8080:80 my-laravel-app
                    '''
                }
            }
        }

        stage('Laravel Optimization & Cache Clear') {
            steps {
                echo 'Clearing Laravel Views and Config Caches...'
                sh '''
                    docker exec -i laravel_app php artisan optimize:clear
                '''
            }
        }

        stage('Database Backup Trigger (Optional)') {
            steps {
                echo 'Triggering Database Backup to S3...'
                sh '''
                    if [ -f scripts/backup.sh ]; then
                        bash scripts/backup.sh
                    fi
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment Pipeline completed successfully!'
        }
        failure {
            echo 'Deployment Pipeline failed! Check logs.'
        }
    }
}
