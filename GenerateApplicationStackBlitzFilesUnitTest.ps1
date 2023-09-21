function Create-StackblitzFiles() {

    param (
        [Parameter(Mandatory)] [pscustomobject]$StackblitzFiles,
        [Parameter(Mandatory)] [string]$Location
    )

   $StackBlitz | ForEach-Object {

   Write-Host -f Green "APPLICATION ID:" $_.applicationId

    try
    {
     for($i = 0; $i -lt $_.modules.length; $i++){ 
   
     $FolderPath = $Location + $_.modules[$i].moduleName;
  
     #Validate folder if exist
     If (Test-Path $FolderPath) {
      $WarningMsg = $_.modules[$i].moduleName + " FOLDER ALREADY EXIST!"
      Write-Warning $WarningMsg
     }else{
      # Create a folder
      New-Item -Path  $FolderPath -ItemType Directory
       Write-Host -f Green $_.modules[$i].moduleName "FOLDER SUCCESSFULLY CREATED!"

     for($x = 0; $x -lt $_.modules[$i].files.length; $x++){ 
      
     $FilePath = $FolderPath + '\' + $_.modules[$i].files[$x].fileName

     #Validate file if exist
     If (Test-Path $FilePath ) {

      $WarningMsg = $_.modules[$i].files[$x].fileName + " FILE ALREADY EXIST!"
      Write-Warning $WarningMsg

      }
      else{ 
  
       # File creation
       New-Item -Path $FilePath -ItemType File -Value $_.modules[$i].files[$x].fileContent
    
       Write-Host -f Green $_.modules[$i].files[$x].fileName "SUCCESSFULLY CREATED!"
      }
    
      }
     }

    }

    }catch
    {
     $ErrorMsg = $_.Exception.Message  
     Write-Host "Application Id:" $_.applicationId $ErrorMsg -BackgroundColor Red 
    }
     
 }
}


$StackBlitzFiles = [pscustomobject]@{applicationId = 1; 
modules = @(
    [pscustomobject]@{moduleName = "profile"; 
    files = @(
        [pscustomobject]@{
         fileName = "profile.component.css";
         fileContent = ".profile-dashboard-container { \r\n    background: #FBF6F0;\r\n    height: 120vh;\r\n    widows: 100%;\r\n}\r\n\r\n.profile-dashboard-main {\r\n    width: 90%;\r\n    padding: 1em;\r\n    margin: auto;\r\n    font-family: Poppins, Helvetica, \'sans-serif\' !important;\r\n}\r\n\r\n.profile-dashboard-row-1 {\r\n    background: white;\r\n    \/* height: 97vh; *\/\r\n    padding-bottom: 2em;\r\n    overflow: auto;\r\n    border-radius: 24px;\r\n    margin-right: 12px;\r\n}\r\n\r\n.mt4 {margin-top:10px}\r\n.full-width { width: 100%}\r\n\r\n.nav-container { \r\n    margin-bottom: 5px;\r\n    cursor: default;\r\n}\r\n\r\n\r\n\r\n\/**\/\r\n\r\nsection.pd-card {\r\n    background: white;\r\n    padding: 2em;\r\n    margin-bottom: 10px;\r\n    border-radius: 10px;\r\n    font-size: 12px;\r\n}\r\n\r\n.pdr2 {\r\n    height: 97vh;\r\n    margin-right: 10px;\r\n}\r\n\r\n.pdr3 {\r\n    height: 97vh;\r\n}\r\n.profile-dashboard-container { \r\n    background: #FBF6F0;\r\n    height: 120vh;\r\n    widows: 100%;\r\n}\r\n\r\n.profile-dashboard-main {\r\n    width: 90%;\r\n    padding: 1em;\r\n    margin: auto;\r\n    font-family: Poppins, Helvetica, \'sans-serif\' !important;\r\n}\r\n\r\n.profile-dashboard-row-1 {\r\n    background: white;\r\n    \/* height: 97vh; *\/\r\n    padding-bottom: 2em;\r\n    overflow: auto;\r\n    border-radius: 24px;\r\n    margin-right: 12px;\r\n}\r\n\r\n.mt4 {margin-top:10px}\r\n.full-width { width: 100%}\r\n\r\n.nav-container { \r\n    margin-bottom: 5px;\r\n    cursor: default;\r\n}\r\n\r\n\r\n\r\n\/**\/\r\n\r\nsection.pd-card {\r\n    background: white;\r\n    padding: 2em;\r\n    margin-bottom: 10px;\r\n    border-radius: 10px;\r\n    font-size: 12px;\r\n}\r\n\r\n.pdr2 {\r\n    height: 97vh;\r\n    margin-right: 10px;\r\n}\r\n\r\n.pdr3 {\r\n    height: 97vh;\r\n}\r\n"
        },
        [pscustomobject]@{
         fileName = "profile.component.html";
         fileContent = '<section class=\"profile-dashboard-container\">\r\n    <!---->\r\n    <div fxLayout=\"row\">\r\n        <div class=\"profile-dashboard-main\" fxLayoutAlign=\"center center\">\r\n            <!---->\r\n            <div class=\"profile-dashboard-row-1\" fxLayout=\"column\" fxLayoutAlign=\"start start\" fxFlex=\"18\">\r\n               <app-profile-dashboard-side-nav class=\"full-width\" [navlist]=\"navlist\" [username]=\"username\"><\/app-profile-dashboard-side-nav>\r\n            <\/div>\r\n            <!---->\r\n            <div class=\"pdr2\" fxLayout=\"column\" fxFlex>\r\n                \r\n                <!---->\r\n                <app-profile-dashboard-card [viewType]=\""tab"\" [data]=\"tabCardData\" [listData]=\"productList\" [storeListData]=\"storeList\">\r\n                <\/app-profile-dashboard-card>\r\n                <!---->\r\n                \r\n                <!---->\r\n                <app-profile-dashboard-card [viewType]=\""table"\" [data]=\"{title: "My Orders"}\" [columns]=\"myOrdersColumns\" [listData]=\"orderList\"><\/app-profile-dashboard-card>\r\n                <!---->\r\n\r\n                <!---->\r\n                <app-profile-dashboard-card [viewType]=\"table"\" [data]=\"{title: "Transaction History"}\" [columns]=\"transactionHistoryColumns\" [listData]=\"transactionList\"><\/app-profile-dashboard-card>\r\n                <!---->\r\n\r\n            <\/div>\r\n\r\n            <!---->\r\n            <div class=\"pdr3\" fxLayout=\"column\" fxFlex=\"30\">\r\n                 <!---->\r\n                 <app-profile-dashboard-card [viewType]=\""chart"\" [data]=\"{title: "Monthly Sales"}\"><\/app-profile-dashboard-card>\r\n                 <!---->\r\n\r\n                 <!---->\r\n                 <app-profile-dashboard-card [viewType]=\""message"\" [data]=\"{title: "My Message"}\"><\/app-profile-dashboard-card>\r\n                 <!---->\r\n            <\/div>\r\n        <\/div>\r\n    <\/div>\r\n    <!---->\r\n<\/section>\r\n'
        },
        [pscustomobject]@{
        fileName = "profile.component.ts";
        fileContent = "import { ChangeDetectorRef, Component, OnInit } from '@angular\/core';\r\nimport { ProfileService } from '.\/profile.service';\r\nimport { AuthorizeService } from '..\/..\/api-authorization\/authorize.service';\r\nimport { combineLatest, Observable } from 'rxjs';\r\n@Component({\r\n  selector: 'app-profile',\r\n  templateUrl: '.\/profile.component.html',\r\n  styleUrls: ['.\/profile.component.css']\r\n})\r\nexport class ProfileComponent implements OnInit {\r\n  navlist = [\r\n    { name: 'Dashboard', icon: 'home', hasChild: false, childs: [], iconSize: null},\r\n    { name: 'Stores', icon: 'desktop_windows', hasChild: false, childs: [], iconSize: 19},\r\n    { name: \'My NFT's\, icon: 'lens_blur', hasChild: false, childs: [], iconSize: null},\r\n    { name: 'My Earnings', icon: 'account_balance_wallet', hasChild: false, childs: [], iconSize: 21},\r\n    { name: 'My Orders', icon: 'inventory_2', hasChild: true, childs: [], iconSize: 20},\r\n    { name: 'Reviews', icon: 'star', hasChild: false, childs: [], iconSize: 21},\r\n    { name: 'Listing', icon: 'assignment', hasChild: false, childs: [], iconSize: 21},\r\n    { name: 'History', icon: 'history', hasChild: false, childs: [], iconSize: 22},\r\n    { name: 'Ad Managers', icon: 'campaign', hasChild: false, childs: [], iconSize: 23},\r\n    { name: 'Shop Widget', icon: 'extension', hasChild: false, childs: [], iconSize: 20},\r\n    { name: 'Settings', icon: 'tune', hasChild: false, childs: [], iconSize: 22},\r\n  ];\r\n  \r\n  tabCardData = [\r\n    { name: 'Stores', tabDetails: null},\r\n    { name:  \'MyNFTs\', tabDetails: null},\r\n  ]\r\n\r\n  transactionHistoryColumns = ['Event', 'From', 'To', 'Date'];\r\n  myOrdersColumns = ['Item', 'Price', 'Store', 'Date' ];\r\n  productList: any;\r\n  storeList: any;\r\n  username: any;\r\n  orderList: any;\r\n  transactionList: any;\r\n  reqs: Observable<any>[] = [];\r\n\r\n  constructor(private profileDashboardService: ProfileService, private authorizeService: AuthorizeService,\r\n             private cdr: ChangeDetectorRef) { }\r\n\r\n  ngOnInit(): void {\r\n    this.reqs.push(\r\n      this.profileDashboardService.getCatalogItemsByUser(this.authorizeService.getClaims().sub),\r\n      this.profileDashboardService.getStoresByUser(this.authorizeService.getClaims().sub),\r\n      this.profileDashboardService.getOrdersByUser(this.authorizeService.getClaims().sub),\r\n      this.profileDashboardService.getTransactionsByUser(this.authorizeService.getClaims().sub)\r\n    );\r\n\r\n    this.username = this.authorizeService.getClaims().preferred_username;\r\n\r\n    combineLatest(this.reqs).subscribe(result => {\r\n      if (result.length > 0) {\r\n        this.productList = result[0];\r\n        this.storeList = result[1];\r\n        this.orderList = result[2];\r\n        this.transactionList = result[3];\r\n\r\n        this.cdr.detectChanges();\r\n      }\r\n    });\r\n\r\n  }\r\n\r\n  setSize(size){\r\n\r\n    if(size == null){\r\n      return '24px';\r\n    } else {\r\n      return size + 'px';\r\n    }\r\n  }\r\n\r\n}\r\n"
        },
        [pscustomobject]@{
        fileName = "profile.module.ts";
        fileContent = "import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular\/core';\r\nimport { CommonModule } from '@angular\/common';\r\nimport { FlexLayoutModule, FlexModule } from '@angular\/flex-layout';\r\nimport { MatCardModule } from '@angular\/material\/card';\r\nimport { MatMenuModule } from '@angular\/material\/menu';\r\nimport { MatInputModule } from '@angular\/material\/input';\r\nimport { MatSelectModule } from '@angular\/material\/select';\r\nimport { MatRadioModule } from '@angular\/material\/radio';\r\nimport { BrowserModule } from '@angular\/platform-browser';\r\nimport { LayoutModule } from '@angular\/cdk\/layout';\r\nimport { BrowserAnimationsModule } from '@angular\/platform-browser\/animations';\r\nimport { FormsModule, ReactiveFormsModule } from '@angular\/forms';\r\nimport { MatButtonModule } from '@angular\/material\/button';\r\nimport { ProfileComponent } from '.\/profile.component';\r\nimport { MatTabsModule } from '@angular\/material\/tabs';\r\nimport { MatCheckboxModule } from '@angular\/material\/checkbox';\r\nimport { MatIconModule } from '@angular\/material\/icon';\r\nimport { MainHeaderModule } from '..\/main-header\/main-header.module';\r\nimport { ProfileDashboardSideNavComponent } from '.\/profile-dashboard-side-nav\/profile-dashboard-side-nav.component';\r\nimport { ProfileDashboardCardComponent } from '.\/profile-dashboard-card\/profile-dashboard-card.component';\r\nimport { ProfileProductListComponent } from '.\/profile-product-list\/profile-product-list.component';\r\nimport { ProfileStoreListComponent } from '.\/profile-store-list\/profile-store-list.component';\r\n\r\nimport { PipesModule } from '..\/pipes\/pipes.module';\r\n\r\n@NgModule({\r\n  declarations: [\r\n    ProfileComponent, \r\n    ProfileDashboardSideNavComponent, \r\n    ProfileDashboardCardComponent, \r\n    ProfileProductListComponent,\r\n    ProfileStoreListComponent\r\n  ],\r\n  imports: [\r\n    BrowserModule,\r\n    BrowserAnimationsModule,\r\n    LayoutModule,\r\n    CommonModule,\r\n    FlexLayoutModule,\r\n    MatCardModule,\r\n    MatMenuModule,\r\n    MatInputModule,\r\n    MatSelectModule,\r\n    MatRadioModule,\r\n    ReactiveFormsModule,\r\n    FormsModule,\r\n    MatButtonModule,\r\n    MatCheckboxModule,\r\n    MatIconModule,\r\n    MatTabsModule,\r\n    MainHeaderModule,\r\n    PipesModule\r\n  ],\r\n  schemas: [ CUSTOM_ELEMENTS_SCHEMA ]\r\n})\r\nexport class ProfileModule { }\r\n"
        }
       )
    }
  )
}

$Location = "C:\Users\MarcKennethLomio\source\repos\na\na.app\src\api\na.app.Test\Powershellscripts\na.app.SPA\ClientApp\src\app\pages\"

Create-StackblitzFiles $StackBlitzFiles $Location