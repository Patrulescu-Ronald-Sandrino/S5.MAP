package com.example.booksapp.di

import android.content.Context
import androidx.room.Room.databaseBuilder
import androidx.room.RoomDatabase
import androidx.sqlite.db.SupportSQLiteDatabase
import com.example.booksapp.core.Constraints.Companion.BOOK_TABLE
import com.example.booksapp.data.network.BookDAO
import com.example.booksapp.data.network.BookDatabase
import com.example.booksapp.data.repository.BookRepository
import com.example.booksapp.domain.IBookRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import java.io.File
import java.util.concurrent.Executors
import javax.security.auth.callback.Callback

@Module
@InstallIn(SingletonComponent::class)
class AppModule {
    @Provides
    fun provideBookDatabase(
        @ApplicationContext context : Context
    ) = databaseBuilder(
        context,
        BookDatabase::class.java,
        BOOK_TABLE
    ).createFromFile(File("src/main/java/com/example/booksapp/data/network/BookDatabase.kt"))
        .build()

    @Provides
    fun provideBookDAO(
        bookDB: BookDatabase
    ) = bookDB.bookDAO()

    @Provides
    fun provideBookRepository(
        bookDAO: BookDAO
    ): IBookRepository = BookRepository(
        bookDAO = bookDAO
    )
}