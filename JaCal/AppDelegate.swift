//
//  AppDelegate.swift
//  JaCal
//
//  Created by Jake Song on 8/27/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var tasksViewController: TasksViewController!
  var calendar: CalendarViewController!

  func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  func applicationWillResignActive(application: UIApplication!) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication!) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication!) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication!) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication!) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    self.saveContext()
  }

  // MARK: - Core Data Saving support

  func saveContext () {
    var error: NSError? = nil
    if 관리된_객체_맥락.hasChanges && !관리된_객체_맥락.save(&error) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog("Unresolved error \(error), \(error!.userInfo)")
//        abort()
    }
  }

  func selectedTask() -> Task? {
    return tasksViewController.selectedTask()
  }

  func addTask(icon: String, title: String) {
    let task = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: 관리된_객체_맥락) as Task
    task.title = title
    task.icon = icon
    task.dones = NSSet()
    tasksViewController.addTask(task)
    saveContext()
  }

  func modifyTask(task: Task, icon: String, title: String) {
    task.title = title
    task.icon = icon
    tasksViewController.refresh()
    calendar.refresh()
    saveContext()
  }

  func 한걸로(를 목표: Task, 에 날짜: NSTimeInterval) -> TaskDone {
    let 한일 = NSEntityDescription.insertNewObjectForEntityForName("TaskDone" as NSString, inManagedObjectContext: 관리된_객체_맥락) as TaskDone
    한일.task = 목표
    한일.date = 날짜
    목표.dones = 목표.dones.setByAddingObject(한일)
    saveContext()
    return 한일
  }

  func 삭제(을 한적: TaskDone) {
    관리된_객체_맥락.deleteObject(한적)
    saveContext()
  }

  func tasks() -> [Task] {
    let 요구 = NSFetchRequest()
    요구.entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: 관리된_객체_맥락)
    요구.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
    var 에러: NSError?
    let 불러온거 = 관리된_객체_맥락.executeFetchRequest(요구, error: &에러)
    return 불러온거 as [Task]
  }

  func 기록들() -> [TaskDone] {
    let 요구 = NSFetchRequest()
    요구.entity = NSEntityDescription.entityForName("TaskDone" as NSString, inManagedObjectContext: 관리된_객체_맥락)
    var 에러: NSError?
    let 불러들인거 = 관리된_객체_맥락.executeFetchRequest(요구, error: &에러)
    return 불러들인거 as [TaskDone]
  }

  lazy var 관리된_객체_맥락: NSManagedObjectContext = {
    let 모델 = NSManagedObjectModel.mergedModelFromBundles(NSBundle.allBundles())
    let 지속저장코디 = NSPersistentStoreCoordinator(managedObjectModel: 모델!)

    let 유알엘 = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last?.URLByAppendingPathComponent("JaCal.sqlite")

    let 옵션 = [
      NSPersistentStoreFileProtectionKey: NSFileProtectionComplete,
      NSMigratePersistentStoresAutomaticallyOption: true,
      NSInferMappingModelAutomaticallyOption: true]
    var 에러: NSError? = nil
    var 저장소 = 지속저장코디.addPersistentStoreWithType(NSSQLiteStoreType, configuration:nil, URL:유알엘, options:옵션, error:&에러)
    if 저장소 == nil {
      NSLog("Error adding persistent store. Error \(에러)")

      var 삭제에러: NSError? = nil
      if !NSFileManager.defaultManager().removeItemAtURL(유알엘!, error:&삭제에러) {
        에러 = nil;
        저장소 = 지속저장코디.addPersistentStoreWithType(NSSQLiteStoreType, configuration:nil, URL:유알엘, options: 옵션, error:&에러)
      }

      if 저장소 == nil {
        // Also inform the user...
        NSLog("Failed to create persistent store. Error \(에러). Delete error \(삭제에러)")
        abort()
      }
    }

    let 맥락 = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    맥락.persistentStoreCoordinator = 지속저장코디
    return 맥락
  }()
}

var app: AppDelegate = {
  return UIApplication.sharedApplication().delegate as AppDelegate
}()
