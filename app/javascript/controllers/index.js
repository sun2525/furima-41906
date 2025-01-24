// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";  // Stimulusアプリケーションをインポート
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"; // Stimulusのコントローラを遅延読み込みするためのヘルパー

// Stimulusコントローラを一括で読み込む設定
eagerLoadControllersFrom("controllers", application);  // 'controllers'ディレクトリ内の全てのコントローラをアプリケーションに登録
