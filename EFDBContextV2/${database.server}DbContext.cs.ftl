<#-- @ftlvariable name="table" type="bbd.jportal2.Table" -->
<#import "basefunctions.ftl" as base>
// ########################################################################################################################
// ################## Generated Code. DO NOT CHANGE THIS CODE. Change it in the generator and regenerate ##################
// ########################################################################################################################
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using Bbd.Vanguard.${database.getServer()}.EntityFrameworkCore.Models;

namespace Bbd.Vanguard.${database.getServer()}.EntityFrameworkCore
{
    public abstract class ${database.getServer()}DbContext : DbContext, I${database.getServer()}DbContext
    {
        public ${database.getServer()}DbContext([NotNull] DbContextOptions options) : base(options) { }

        <#list database.getTables() as table>
        public DbSet<${table.name}Entity> ${table.name}Entity { get; set; }
        <#list table.procs as proc>
        <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "" && proc.name != "Identity" && proc.lines?size gt 0 && proc.outputs?size gt 0>
        protected DbSet<${table.name}Entity_${proc.name}> ${table.name}_${proc.name}Set { get; set; }
        </#if>
        </#list>
        </#list>
        protected virtual string GetTableName(string name) => name;
        protected virtual string GetSchemaName(string name) => name;
        protected virtual string MainSchema() => "${database.getSchema()}";
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            <#list database.getTables() as table>
            modelBuilder.Entity<${table.name}Entity>().ToTable(GetTableName("${table.name}"), GetSchemaName(MainSchema()))<#if !table.hasPrimaryKey>.HasNoKey()<#elseif table.hasPrimaryKey && !table.hasIdentity>.HasKey(${base.getPrimaryKeyFieldsString(table.fields)})</#if>;
            <#list table.procs as proc>
            <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "" && proc.name != "Identity" && proc.lines?size gt 0 && proc.outputs?size gt 0>
            modelBuilder.Entity<${table.name}Entity_${proc.name}>().HasNoKey();
            </#if>
            </#list>
            </#list>
        }

        <#list database.getTables() as table>
        <#list table.procs as proc>
        <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "" && proc.name != "Identity" && proc.lines?size gt 0 && proc.outputs?size gt 0>
        <#--  SI Specific Implementation if ever needed?  -->
        <#--  public abstract <#if proc.isSingle()>Task<${table.name}_${proc.name}><#elseif proc.outputs?size gt 0>Task<IEnumerable<${table.name}_${proc.name}>><#else>Task</#if> Execute${table.name}_${proc.name}  -->
        private static string ${table.name}${proc.name}Statement = @"
<#list base.formatEFLines(proc.lines) as pl>
${pl}
</#list>
";
        public virtual IQueryable<${table.name}Entity_${proc.name}> ${table.name}Entity_${proc.name}(${base.getTypedFields(proc.inputs)})
            => ${table.name}_${proc.name}Set.FromSqlRaw(${table.name}${proc.name}Statement<#if proc.inputs?size gt 0>, </#if><#list proc.inputs as field>${field.name}<#compress><#sep>,</#compress></#list>);
        </#if>
        </#list>
        </#list>
    }
}